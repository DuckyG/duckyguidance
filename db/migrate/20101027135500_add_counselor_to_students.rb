class AddCounselorToStudents < ActiveRecord::Migration
  def self.up
    add_column :students, :counselor_id, :int
  end

  def self.down
    remove_column :students, :counselor_id
  end
end
