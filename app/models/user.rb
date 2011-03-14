class User < ActiveRecord::Base
  acts_as_authentic
  acts_as_authorization_subject
  has_and_belongs_to_many :roles
  belongs_to :name_prefix
  before_save :assign_roles
  belongs_to :school
  attr_accessor :subdomain
  
  def assign_roles
    has_role! :member, subdomain if subdomain
  end
end