class AddIpassFieldsToStudents < ActiveRecord::Migration
  def self.up
    add_column :students, :student_id, :int
    add_column :students, :primary_phone_number, :string
    add_column :students, :city, :string
    add_column :students, :year_of_graduation, :int
    add_column :students, :shop, :string
  end

  def self.down
    remove_column :students, :shop
    remove_column :students, :year_of_graduation
    remove_column :students, :city
    remove_column :students, :primary_phone_number
    remove_column :students, :student_id
  end
end
