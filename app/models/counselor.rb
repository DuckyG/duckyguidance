class Counselor < User
  has_many :students, :foreign_key => "counselor_id"
  has_many :meeting_requests, :foreign_key => "counselor_id"
  has_many :notes, :foreign_key => "counselor_id"
  validates_presence_of :school, :first_name, :last_name

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
