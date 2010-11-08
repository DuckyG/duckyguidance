class RenameMeetingTagsToNotesTags < ActiveRecord::Migration
  def self.up
    rename_table :meeting_tags, :notes_tags
    remove_column :notes_tags, :id
  end

  def self.down
    rename_table :notes_tags, :meeting_tags
  end
end
