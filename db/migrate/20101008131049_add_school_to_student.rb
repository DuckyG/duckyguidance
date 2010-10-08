class AddSchoolToStudent < ActiveRecord::Migration
  def self.up
    add_column :students, :school_id, :int
  end

  def self.down
    remove_column :students, :school_id
  end
end
