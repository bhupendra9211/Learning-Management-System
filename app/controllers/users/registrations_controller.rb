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
      # UserMailer.send_signup_email(@user).deliver_now
      sendgrid_service = SendgridContactService.new(ENV['SENDGRID_API_KEY'], @user.email)
      result = sendgrid_service.add_or_update_user_email

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
      params.require(:user).permit(:email,:password,:password_confirmation)
  end
  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
