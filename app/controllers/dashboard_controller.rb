class DashboardController < ApplicationController
  before_filter :require_counselor
  def index
    @meetings = Meeting.where(['counselor_id = ?',current_counselor.id]).order('occured_on desc').limit(10)
    @title = 'Dashboard'
  end

end
