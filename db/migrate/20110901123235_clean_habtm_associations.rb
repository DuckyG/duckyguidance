class CleanHabtmAssociations < ActiveRecord::Migration
  def self.up
    [:roles_users, :notes_tags, :groups_students].each do |table|
      remove_column table, :created_at
      remove_column table, :updated_at
    end
  end

  def self.down
    [:roles_users, :notes_tags, :groups_students].each do |table|
      add_column table, :created_at, :datetime
      add_column table, :updated_at, :datetime
    end
  end
end
