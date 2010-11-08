class CreateStudentsNotes < ActiveRecord::Migration
  def self.up
    create_table :students_notes, :id => false do |t|
      t.integer :student_id
      t.integer :note_id
    end
  end

  def self.down
    drop_table :students_notes
  end
end
