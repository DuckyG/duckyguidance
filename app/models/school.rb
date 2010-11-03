class School < ActiveRecord::Base
  acts_as_authorization_object
  has_many :counselors
  has_many :students
  has_many :categories
  has_many :tags
  has_many :meetings
  has_many :groups
  has_many :meeting_requests
  belongs_to :subdomain
  
  validates    :name, :address, :city, :state, :zip_code, :subdomain, :presence => true
  
  def new_counselor_attributes=(counselor_attributes)
    school_admin = counselors.build counselor_attributes
    school_admin.has_role! :member, subdomain
    school_admin.has_role! :school_admin, self
  end
  
  def new_subdomain_attributes=(subdomain_attributes)
    self.subdomain = Subdomain.new subdomain_attributes
  end
end
