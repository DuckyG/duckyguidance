class Counselor < User
  has_many :meeting_requests, :foreign_key => "counselor_id"
  has_many :meetings, :foreign_key => "counselor_id"
end
