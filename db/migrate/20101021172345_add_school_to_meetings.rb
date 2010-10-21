class AddSchoolToMeetings < ActiveRecord::Migration
  def self.up
    add_column :meetings, :school_id, :int
  end

  def self.down
    remove_column :meetings, :school_id
  end
end
