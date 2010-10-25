class School < ActiveRecord::Base
  has_many :counselors
  has_many :students
  has_many :categories
  has_many :tags
  has_many :meetings
  has_many :meeting_requests
  validates_uniqueness_of :subdomain
  validates    :name, :address, :city, :state, :zip_code, :subdomain, :presence => true

  def new_counselor_attributes=(counselor_attributes)
    counselors.build counselor_attributes
  end
end
