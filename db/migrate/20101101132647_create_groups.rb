class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string :name, :null => false
      t.string :description, :null => false
      t.integer :school_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :groups
  end
end
