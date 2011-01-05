class AddSystemToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :system, :boolean
  end

  def self.down
    remove_column :categories, :system
  end
end
