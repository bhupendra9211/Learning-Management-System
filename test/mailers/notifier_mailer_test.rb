require "test_helper"

class NotifierMailerTest < ActionMailer::TestCase
  test "create_notifier" do
    mail = NotifierMailer.create_notifier
    assert_equal "Create notifier", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
