class DashboardController < ApplicationController
  before_filter :require_counselor
  def index
    @meetings = Meeting.where(['counselor_id = ?',current_counselor.id]).order('occured_on desc').limit(10)
    @requests = MeetingRequest.where(['counselor_id = ? AND accepted IS NULL',current_counselor.id])
    @upcoming_meetings = MeetingRequest.where(['counselor_id = ? AND accepted = ? AND desired_date > ?',current_counselor.id,"t", DateTime.now]).order('desired_date')

    @title = 'Dashboard'
  end

end
