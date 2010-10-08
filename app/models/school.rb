class School < ActiveRecord::Base
  has_many :counselors
  authenticates_many :counselor_sessions, :scope_cookies => true,  :find_options => { :limit => 1 } 
end
