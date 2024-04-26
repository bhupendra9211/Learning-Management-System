# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  # def create
  #   # Create the user from params
  #   @user = User.new(user_params)
  #   if @user.save
  #     # Deliver the signup email
  #     UserMailer.send_signup_email(@user).deliver_now
  #     redirect_to root_path, notice: 'User created'
  #   else
  #     render :action => 'new'
  #   end

  #   # super
  # end
  def create
    @user = User.new(user_params)

    if @user.save
    #   sendgrid_service = SendgridAllcontactService.new(ENV['SENDGRID_API_KEY'])
    #   result = sendgrid_service.add_all_users(User.all)
    #   if result[:success]
    #     puts 'All users added/updated in SendGrid successfully'
    #   else
    #     puts "Error: #{result[:message]}"
    #   end
      # UserMailer.send_signup_email(@user).deliver_now
      sendgrid_service = SendgridContactService.new(ENV['SENDGRID_API_KEY'], @user.email)
      result = sendgrid_service.add_or_update_user_email

      if result[:success]
        redirect_to root_path, notice: 'User was successfully created and email added/updated in SendGrid.'
      else
        redirect_to root_path, alert: "Error: #{result[:message]}"
      end
    else
      render :new
    end
  
  end

  private

  def user_params
      params.require(:user).permit(:email,:password,:password_confirmation)
  end

end
