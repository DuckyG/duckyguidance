class NotesStudent < ActiveRecord::Base
  belongs_to :note
  belongs_to :student
end
