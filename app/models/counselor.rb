class Counselor < ActiveRecord::Base
  acts_as_authentic
  has_many :meetings
end
