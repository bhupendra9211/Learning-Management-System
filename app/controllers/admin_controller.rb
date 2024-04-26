class AdminController < ApplicationController
  before_action :authenticate_admin!

  def index
    @quick_stats = {
      sign_ups: User.where("created_at > ?", 1.week.ago).count,
      completed_lessons: LessonUser.where("created_at > ?", 1.week.ago).where(completed: true).count,
      total_sign_ups: User.count,
    }
    @most_popular_courses = Course.joins(:course_users).group(:id).order('count(course_users.id) desc').limit(5)
  end

  def add_all_user_to_sendgrid
    # Instantiate your service class
    sendgrid_service = SendgridAllcontactService.new(ENV['SENDGRID_API_KEY'])

    # Call the add_all_users method
    result = sendgrid_service.add_all_users(User.all)

    if result[:success]
      flash[:success] = 'User added/updated in SendGrid successfully'
    else
      flash[:error] = "Error: #{result[:message]}"
    end

    redirect_to root_path # Redirect to appropriate page after action
  end

end
