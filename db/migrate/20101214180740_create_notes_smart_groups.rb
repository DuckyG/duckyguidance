class CreateNotesSmartGroups < ActiveRecord::Migration
  def self.up
    create_table :notes_smart_groups, :id => false do |t|
      t.integer :smart_group_id
      t.integer :note_id
    end
    
    add_foreign_key :notes_smart_groups, :smart_groups
    add_foreign_key :notes_smart_groups, :notes
    add_foreign_key :notes_students, :students
    add_foreign_key :notes_students, :notes
    add_foreign_key :groups_notes, :groups
    add_foreign_key :groups_notes, :notes
  end

  def self.down
    remove_foreign_key :notes_smart_groups, :smart_groups
    remove_foreign_key :notes_smart_groups, :notes
    remove_foreign_key :notes_students, :students
    remove_foreign_key :notes_students, :notes
    remove_foreign_key :groups_notes, :groups
    remove_foreign_key :groups_notes, :notes
    drop_table :notes_smart_groups
    
  end
end
