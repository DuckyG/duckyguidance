class DashboardController < ApplicationController
  layout 'new_application'
  access_control do
    allow :member, :of => :current_subdomain
  end
  def index
    if current_counselor
      #@notes = current_counselor.notes.order('created_at desc').limit(10)
      @notes = Array.new
      current_counselor.students.all.each {|student| @notes = @notes + student.notes }
      @notes = @notes.uniq {|n| n.id}.sort {|x,y| y.created_at <=> x.created_at}.take(10)
      @requests = current_counselor.meeting_requests.where(['accepted IS NULL']).order('desired_date')
      @upcoming_meetings = current_counselor.meeting_requests.where([' accepted = ? AND desired_date > ?',true, DateTime.now]).order('desired_date')
    end
    @title = 'Dashboard'
  end

end
