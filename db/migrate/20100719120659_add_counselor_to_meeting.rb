class AddCounselorToMeeting < ActiveRecord::Migration
  def self.up
    add_column :meetings, :counselor_id, :integer
  end

  def self.down
    remove_column :meetings, :counselor_id
  end
end
