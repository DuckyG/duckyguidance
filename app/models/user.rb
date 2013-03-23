class User < ActiveRecord::Base
  devise :database_authenticatable,  :encryptable, :recoverable, :rememberable, :trackable, :validatable
  belongs_to :name_prefix
  belongs_to :school
  validate :password_meets_requirements
  attr_accessor :subdomain
  has_many :students, :foreign_key => 'counselor_id'
  has_many :notes, :foreign_key => 'counselor_id'
  validates_presence_of :school, :first_name, :last_name
  attr_accessible :name_prefix_id, :first_name, :last_name, :email, :password, :password_confirmation, :remember_me

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
      errors.add(:password, 'must include at least one letter and one number')
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
  end

end
