class School < ActiveRecord::Base
  has_many :counselors
  has_many :students
  has_many :categories
  authenticates_many :counselor_sessions, :scope_cookies => true,  :find_options => { :limit => 1 } 
end
