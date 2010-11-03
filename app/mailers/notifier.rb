class Notifier < ActionMailer::Base
  default :from => "notifications@duckyg.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.request_submitted.subject
  #
  def request_submitted(request)
    @request = request
    @counselor = Counselor.find(@request.counselor_id)
    mail :to => request.email
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.request_received.subject
  #
  def request_received(request)
    @request = request
    @counselor = Counselor.find(@request.counselor_id)

    mail :to => @counselor.email
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.request_accepted.subject
  #
  def request_acknowledged(request)
    @request = request
    @counselor = Counselor.find(@request.counselor_id)
    mail :to => request.email, :cc => @counselor.email
  end

 
end
