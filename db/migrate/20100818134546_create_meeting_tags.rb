class CreateMeetingTags < ActiveRecord::Migration
  def self.up
    create_table :meeting_tags do |t|
      t.integer :meeting_id
      t.integer :tag_id
      t.timestamps
    end
  end

  def self.down
    drop_table :meeting_tags
  end
end
