class DashboardController < ApplicationController
  def index
    @meetings = Meeting.where(['counselor_id = ?',current_counselor.id]).order('occured_on desc').limit(10)
  end

end
