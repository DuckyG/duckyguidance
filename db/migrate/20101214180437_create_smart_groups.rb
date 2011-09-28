class CreateSmartGroups < ActiveRecord::Migration
  def self.up
    create_table :smart_groups do |t|
      t.string :name, :null => false, :unique => true
      t.string :field_name, :null => false
      t.string :field_value, :null => false
      t.integer :school_id, :null => false
      t.timestamps
    end
    
    add_foreign_key :smart_groups, :schools
  end

  def self.down
    remove_foreign_key :smart_groups, :schools
    drop_table :smart_groups
  end
end
