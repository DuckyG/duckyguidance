class AddShowTagsToSchools < ActiveRecord::Migration
  def self.up
    add_column :schools, :show_tags, :boolean, :default => true
    execute <<-SQL
      update schools
      set show_tags = true
    SQL
  end

  def self.down
    remove_column :schools, :show_tags
  end
end
