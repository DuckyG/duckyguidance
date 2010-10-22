class AddSchoolToMeetingRequest < ActiveRecord::Migration
  def self.up
    add_column :meeting_requests, :school_id, :int
  end

  def self.down
    remove_column :meeting_requests, :school_id
  end
end
