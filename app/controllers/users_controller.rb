class UsersController < ApplicationController
  
  def create
    @user = User.new(user_params)

    if @user.save
      # UserMailer.send_signup_email(@user).deliver_now
      sendgrid_service = SendgridContactService.new(ENV['SENDGRID_API_KEY'])
      result = sendgrid_service.add_or_update_user_email(@user.email)

      if result[:success]
        redirect_to @user, notice: 'User was successfully created and email added/updated in SendGrid.'
      else
        redirect_to @user, alert: "Error: #{result[:message]}"
      end
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
