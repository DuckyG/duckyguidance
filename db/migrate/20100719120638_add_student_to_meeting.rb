class AddStudentToMeeting < ActiveRecord::Migration
  def self.up
    add_column :meetings, :student_id, :integer
  end

  def self.down
    remove_column :meetings, :student_id
  end
end
