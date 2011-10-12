class DashboardController < ApplicationController
  access_control do
    allow :member, :of => :current_subdomain
    allow :superadmin
  end
  def index

    @view = params[:view]

    @limit = @view == "list" ? 25 :10
    if current_counselor
      if current_counselor.has_role?(:school_admin, current_school)
        @notes = current_school.notes.page(params[:note_page]).per(@limit)
      else
        note_ids = NotesStudent.where(student_id: current_counselor.student_ids).select(:note_id).map {|n| n.note_id }
        @notes = current_school.notes.where(id: note_ids).limit(@limit).page(params[:note_page]).per(@limit)
      end
    end




    respond_to do |format|
      format.html
      format.js
    end
  end

end
