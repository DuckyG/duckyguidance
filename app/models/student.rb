class Student < ActiveRecord::Base
  has_many :notes
  belongs_to :school
  belongs_to :counselor
  has_and_belongs_to_many :groups
end
