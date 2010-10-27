class IncreaseDatabaseIntegrity < ActiveRecord::Migration
  def self.up
    add_foreign_key :meetings, :users, :column => 'counselor_id'
    add_foreign_key :meetings, :students
    add_foreign_key :meetings, :schools
    add_foreign_key :meetings, :categories
    
    add_foreign_key :meeting_requests, :schools
    add_foreign_key :meeting_requests, :users, :column => 'counselor_id'
    
    add_foreign_key :meeting_tags, :meetings
    add_foreign_key :meeting_tags, :tags
    
    add_foreign_key :students, :schools
    add_foreign_key :students, :users, :column => 'counselor_id'
    
    add_foreign_key :tags, :schools
    
    add_foreign_key :users, :schools
    
    add_foreign_key :categories, :schools
  end

  def self.down
    remove_foreign_key :meetings, :users
    remove_foreign_key :meetings, :students
    remove_foreign_key :meetings, :schools
    remove_foreign_key :meetings, :categories
    
    remove_foreign_key :meeting_requests, :users
    remove_foreign_key :meeting_requests, :users
    
    remove_foreign_key :meeting_tags, :meetings
    remove_foreign_key :meeting_tags, :tags
    
    remove_foreign_key :students, :schools
    remove_foreign_key :students, :users
    
    remove_foreign_key :tags, :schools
    
    remove_foreign_key :users, :schools
    
    remove_foreign_key :categories, :schools
  end
end
