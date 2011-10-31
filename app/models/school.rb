class School < ActiveRecord::Base
  has_many :counselors
  has_many :students
  has_many :categories
  has_many :tags
  has_many :notes
  has_many :groups
  has_many :meeting_requests
  has_many :smart_groups
  belongs_to :subdomain
  
  validates    :name, :address, :city, :state, :zip_code, :subdomain, :presence => true
  validates_uniqueness_of :name 
  def new_counselor_attributes=(counselor_attributes)
    school_admin = counselors.build counselor_attributes
    school_admin.school = self
    school_admin.role = "counselor"
  end
  
  def new_subdomain_attributes=(subdomain_attributes)
    self.subdomain = Subdomain.new subdomain_attributes
  end
end
