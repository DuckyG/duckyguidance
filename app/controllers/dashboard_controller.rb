class DashboardController < ApplicationController
  before_filter :require_counselor
  def index
    if current_counselor
      @meetings = current_counselor.meetings.order('occured_on desc').limit(10)
      @requests = current_counselor.meeting_requests.where(['accepted IS NULL'])
      @upcoming_meetings = current_counselor.meeting_requests.where([' accepted = ? AND desired_date > ?',true, DateTime.now]).order('desired_date')
    end
    @title = 'Dashboard'
  end

end
