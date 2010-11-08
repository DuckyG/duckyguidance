class RenameStudentsNotesTable < ActiveRecord::Migration
  def self.up
    rename_table :students_notes, :notes_students
  end

  def self.down
    rename_table :notes_students, :students_notes
  end
end
