class CreateGroupsNotesTable < ActiveRecord::Migration
  def self.up
    create_table :groups_notes, :id => false do |t|
      t.integer :group_id, :null => false
      t.integer :note_id, :null => false
    end
  end

  def self.down
    drop_table :groups_notes
  end
end
