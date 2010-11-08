class RenameMeetingToNotes < ActiveRecord::Migration
  def self.up
    rename_table :meetings, :notes
  end

  def self.down
    rename_table :notes, :meetings
  end
end
