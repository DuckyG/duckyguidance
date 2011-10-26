class DashboardController < ApplicationController
  before_filter :authenticate_user_against_school!
  def index
    if current_counselor
      if current_counselor.has_role?(:school_admin, current_school)
        @notes = current_school.notes
      else
        note_ids = NotesStudent.where(student_id: current_counselor.student_ids).select(:note_id).map {|n| n.note_id }
        @notes = current_school.notes.where(id: note_ids)
      end
      page_notes
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

end
