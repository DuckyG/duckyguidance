class Note < ActiveRecord::Base
  has_and_belongs_to_many :students
  
  belongs_to :counselor
  belongs_to :category
  belongs_to :school
  attr_accessor :notify_students_counselor, :tags_string, :student_ids
  validates :counselor, :notes, :summary, :category, :presence => true 
  before_validation :convert_meta
  has_and_belongs_to_many :tags

  def get_tag_string
    arr = []
    tags.each {|tag| arr.push tag.name}
    arr.join ' '
  end

  
  def convert_meta
    get_tags if @tags_string
    convert_student_ids
  end
  
  def convert_student_ids
    logger.debug "IDs:" + @student_ids
    unless @student_ids.nil?
      logger.debug "IDs:" + @student_ids
      @student_ids.split(',').each do |id|
        logger.debug "ID:" + id
        student = school.students.find id
        self.students<<student
      end
    end
  end

  def get_tags
    tag_list = @tags_string.split ' '
    tag_array = []
    tag_list.each do |tag_str|
      if !tag_str.strip.empty?
        tag = school.tags.find_by_name tag_str.downcase
        if !tag
          tag = school.tags.create(:name =>tag_str.downcase )

        end
        tag_array.push tag 
      end
    end
    self.tags = tag_array
  end
end
