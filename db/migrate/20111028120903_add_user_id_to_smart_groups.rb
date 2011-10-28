class AddUserIdToSmartGroups < ActiveRecord::Migration
  def self.up
    add_column :smart_groups, :user_id, :integer
  end

  def self.down
    remove_column :smart_groups, :user_id
  end
end
