require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "request_submitted" do
    mail = Notifier.request_submitted
    assert_equal "Request submitted", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "request_received" do
    mail = Notifier.request_received
    assert_equal "Request received", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "request_accepted" do
    mail = Notifier.request_accepted
    assert_equal "Request accepted", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "request_rejected" do
    mail = Notifier.request_rejected
    assert_equal "Request rejected", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
