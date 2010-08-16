class AddAcceptedToMeetingRequest < ActiveRecord::Migration
  def self.up
    add_column :meeting_requests, :accepted, :boolean
  end

  def self.down
    remove_column :meeting_requests, :accepted
  end
end
