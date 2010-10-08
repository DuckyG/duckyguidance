class AddSchoolToCounselor < ActiveRecord::Migration
  def self.up
    add_column :counselors, :school_id, :int
  end

  def self.down
    remove_column :counselors, :school_id
  end
end
