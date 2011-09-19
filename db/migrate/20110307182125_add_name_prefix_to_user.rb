class AddNamePrefixToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :name_prefix_id, :integer
  end

  def self.down
    remove_column :users, :name_prefix_id
  end
end
