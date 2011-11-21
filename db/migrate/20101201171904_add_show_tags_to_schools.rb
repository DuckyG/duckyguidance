class AddShowTagsToSchools < ActiveRecord::Migration
  def self.up
    add_column :schools, :show_tags, :boolean, :default => true

  end

  def self.down
    remove_column :schools, :show_tags
  end
end
