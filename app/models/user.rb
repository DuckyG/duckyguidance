class User < ActiveRecord::Base
  acts_as_authentic
  acts_as_authorization_subject
  has_and_belongs_to_many :roles
  belongs_to :name_prefix
  before_save :assign_roles
  belongs_to :school
  validate :password_meets_requirements
  attr_accessor :subdomain
  
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