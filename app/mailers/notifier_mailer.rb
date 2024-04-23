class NotifierMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier_mailer.create_notifier.subject
  #
  def create_notifier(object)
    # This object can be anything like - object of student model, object of course model or whatever the model in our application
    @object = object
    @object_count = object.class.count

    mail to: 'admin@gmail.com', subject: "New entry for #{object.class} has been created !"

  end
end
