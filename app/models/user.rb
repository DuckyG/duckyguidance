class User < ActiveRecord::Base
  acts_as_authorization_subject
  has_many :roles_users
  has_many :roles, :through => :roles_users
  belongs_to :name_prefix
  before_create :assign_roles 
  belongs_to :school
  validate :password_meets_requirements
  attr_accessor :subdomain
  
  def formal_name
     "#{name_prefix.prefix if name_prefix} #{last_name}"
   end

   def full_name
     "#{first_name} #{last_name}"
   end
  
  def password_meets_requirements
    return true if password.blank?
    
    unless password.length > 5 && password =~ /(\w)/ && password =~ /(\d)/
      errors.add_to_base("Password must be 6 characters or longer, and include at least one letter and one number")
    end
  end
  
  def assign_roles
    has_role! :member, subdomain if subdomain
  end
end
