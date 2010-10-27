class Student < ActiveRecord::Base
  has_many :meetings
  belongs_to :school
  belongs_to :counselor
end
