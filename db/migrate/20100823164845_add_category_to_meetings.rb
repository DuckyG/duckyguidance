class AddCategoryToMeetings < ActiveRecord::Migration
  def self.up
    add_column :meetings, :category_id, :int
  end

  def self.down
    remove_column :meetings, :category_id
  end
end
