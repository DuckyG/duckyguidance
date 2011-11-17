class AddShowTagsToSchools < ActiveRecord::Migration
  def self.up
    add_column :schools, :show_tags, :boolean, :default => true

    School.each do |s|
      s.show_tags = true
      s.save
    end
  end

  def self.down
    remove_column :schools, :show_tags
  end
end
