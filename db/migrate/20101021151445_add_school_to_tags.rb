class AddSchoolToTags < ActiveRecord::Migration
  def self.up
    add_column :tags, :school_id, :int
  end

  def self.down
    remove_column :tags, :school_id
  end
end
