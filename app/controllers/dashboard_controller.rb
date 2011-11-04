class DashboardController < ApplicationController
  before_filter :authenticate_user_against_school!
  def index
    if current_user
      if current_user.director?
        @notes = Note.accessible_by(current_ability)
      else
        note_ids = NotesStudent.where(student_id: current_user.student_ids).select(:note_id).map {|n| n.note_id }
        user_id = current_user.id
        @notes = Note.accessible_by(current_ability).where{ (id >> note_ids) | (counselor_id == user_id) }
      end
      page_notes
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

end
