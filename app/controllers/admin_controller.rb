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
end
