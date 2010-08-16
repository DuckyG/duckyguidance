class DashboardController < ApplicationController
  before_filter :require_counselor
  def index
    @meetings = Meeting.where(['counselor_id = ?',current_counselor.id]).order('occured_on desc').limit(10)
    @requests = MeetingRequest.where(['counselor_id = ? AND accepted IS NULL',current_counselor.id])
    @requests.each {|p| puts p.accepted}
    @title = 'Dashboard'
  end

end
