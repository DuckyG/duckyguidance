class DashboardController < ApplicationController
  layout 'new_application'
  access_control do
    allow :member, :of => :current_subdomain
  end
  def index
    if current_counselor
      #@notes = current_counselor.notes.order('created_at desc').limit(10)
      @notes = Array.new
      current_counselor.students.all.each {|student| student.notes.each { |note| @notes.push note} }
      @notes.sort! {|x,y| y.created_at <=> x.created_at}
      @requests = current_counselor.meeting_requests.where(['accepted IS NULL'])
      @upcoming_meetings = current_counselor.meeting_requests.where([' accepted = ? AND desired_date > ?',true, DateTime.now]).order('desired_date')
    end
    @title = 'Dashboard'
  end

end
