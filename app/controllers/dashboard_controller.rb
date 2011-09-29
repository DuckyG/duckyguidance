class DashboardController < ApplicationController
  access_control do
    allow :member, :of => :current_subdomain
    allow :superadmin
  end
  def index
    if current_counselor
      #@notes = current_counselor.notes.order('created_at desc').limit(10)
      if current_counselor.has_role?(:school_admin, current_school)
        @notes = current_school.notes.limit(10)
        logger.info @notes.to_sql
      else
        @notes = Array.new
        current_counselor.students.all.each {|student| @notes = @notes + student.notes if student.school == current_school }
        @notes = @notes.uniq {|n| n.id}.sort {|x,y| y.created_at <=> x.created_at}.take(10)
      end
      @requests = current_counselor.meeting_requests.where(['accepted IS NULL']).order('desired_date')
      @upcoming_meetings = current_counselor.meeting_requests.accepted.future.order('desired_date').take(10)
    end
    @section = 'Dashboard'
  end

end
