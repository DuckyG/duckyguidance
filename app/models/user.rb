class User < ActiveRecord::Base
  acts_as_authorization_subject
  devise :database_authenticatable,  :encryptable, :recoverable, :rememberable, :trackable, :validatable
  has_many :roles_users
  has_many :roles, :through => :roles_users
  belongs_to :name_prefix
  before_create :assign_roles
  belongs_to :school
  validate :password_meets_requirements
  attr_accessor :subdomain
  has_many :students, :foreign_key => "counselor_id"
  has_many :meeting_requests, :foreign_key => "counselor_id"
  has_many :notes, :foreign_key => "counselor_id"
  validates_presence_of :school, :first_name, :last_name

  def update_with_password(params={})
    params.delete(:current_password)
    self.update_without_password(params)
  end	


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

  def counselor?
    director? or role == "counselor"
  end

  def director?
    role == "director"
  end

  private

  def assign_roles
    has_role! :counselor, school
    self.subdomain = school.subdomain
    has_role! :member, subdomain if subdomain
  end

end
