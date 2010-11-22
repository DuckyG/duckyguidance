class Student < ActiveRecord::Base
  has_and_belongs_to_many :notes
  belongs_to :school
  belongs_to :counselor
  has_and_belongs_to_many :groups
  has_many :guardians
end
