class Counselor < User
  
  
  has_many :meeting_requests, :foreign_key => "counselor_id"
  has_many :meetings, :foreign_key => "counselor_id"
  validate :school, :presence => true
  private
  
  def assign_roles
    logger.debug "Hit counselor assign roles"
    has_role! :counselor, school
    super
  end
end
