class RemoveStudentIdFromNotes < ActiveRecord::Migration
  def self.up
    remove_column :notes, :student_id
  end

  def self.down
    add_column :notes, :student_id, :integer
  end
end
