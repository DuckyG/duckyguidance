class Counselor < User
  devise :database_authenticatable,  :encryptable, :recoverable, :rememberable, :trackable, :validatable
  has_many :students, :foreign_key => "counselor_id"
  has_many :meeting_requests, :foreign_key => "counselor_id"
  has_many :notes, :foreign_key => "counselor_id"
  validates_presence_of :school, :first_name, :last_name

  def send_reset_password_instructions_without_delay
    # We have to set the host for ActionMailer, as Devise depends on it when crafting emails.
    # Since emails are handled by delayed_job, the ApplicationController is never accessed, thus the domain is not set
    ActionMailer::Base.default_url_options[:host] = "#{self.school.subdomain.name}.duckyg.com"
    super
  end

  def update_with_password(params={})
    params.delete(:current_password)
    self.update_without_password(params)
  end	

  private

  def assign_roles
    has_role! :counselor, school
    self.subdomain = school.subdomain
    super
  end
end
