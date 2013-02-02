class NamePrefix < ActiveRecord::Base
  attr_accessible :prefix
  has_many :users
end
