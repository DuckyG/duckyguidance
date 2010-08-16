class AddDurationToMeeting < ActiveRecord::Migration
  def self.up
    add_column :meetings, :duration, :int
  end

  def self.down
    remove_column :meetings, :duration
  end
end
