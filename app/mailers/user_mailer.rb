class UserMailer < ApplicationMailer
    def send_signup_email(user)
      @user = user
      mail to: 'admin@gmail.com', subject: "New entry for #{user.class} has been created !"
    end
end
