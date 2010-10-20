class AddSchoolToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :school_id, :int
  end

  def self.down
    remove_column :categories, :school_id
  end
end
