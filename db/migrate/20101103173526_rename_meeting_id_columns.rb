class RenameMeetingIdColumns < ActiveRecord::Migration
  def self.up
    rename_column :notes_tags, :meeting_id, :note_id
  end

  def self.down
    rename_column :notes_tags, :note_id, :meeting_id
  end
end
