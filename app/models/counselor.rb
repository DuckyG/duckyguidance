class Counselor < User
  has_many :students, :foreign_key => "counselor_id"
  has_many :meeting_requests, :foreign_key => "counselor_id"
  has_many :notes, :foreign_key => "counselor_id"
  validates_presence_of :school, :first_name, :last_name
  
  def formal_name
    "#{name_prefix.prefix if name_prefix} #{last_name}"
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  private
  
  def assign_roles
    has_role! :counselor, school
    super
  end
  
  
  
end
