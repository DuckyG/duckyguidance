class Note < ActiveRecord::Base
  has_and_belongs_to_many :students
  has_and_belongs_to_many :groups
  belongs_to :counselor
  belongs_to :category
  belongs_to :school
  attr_accessor :notify_students_counselor, :tags_string, :student_ids, :group_ids
  validates :counselor, :notes, :summary, :category, :presence => true
  before_validation :convert_meta
  has_and_belongs_to_many :tags
  default_scope :order => 'notes.occurred_on ASC'

  def formatted_date_and_time
    occurred_on.strftime '%B %d %Y'
  end

  def get_tag_string
    arr = []
    tags.each {|tag| arr.push tag.name}
    arr.join ' '
  end

  def subject_name
    return "Group: #{groups.first.name}" unless groups.first.nil?
    return students.first.full_name if students.count == 1
    return "Multiple students"
  end

  def convert_meta
    get_tags if @tags_string
    convert_student_ids
    convert_group_ids
  end

  def convert_student_ids
    unless @student_ids.nil?
      @student_ids.split(',').each do |id|
        student = school.students.find id
        self.students<<student
      end
    end
  end

  def convert_group_ids
    unless @group_ids.nil?
      @group_ids.split(',').each do |id|
        group = school.groups.find id
        new_students_to_append = group.students - self.students
        self.students<<new_students_to_append
        self.groups<<group
      end
    end
  end

  def get_tags
    tag_list = @tags_string.split ' '

    tag_list.each do |tag_str|
      if !tag_str.strip.empty?
        tag = school.tags.find_by_name tag_str.downcase
        if !tag
          tag = school.tags.create(:name =>tag_str.downcase )
        end
        self.tags<< tag 
      end
    end
  end
  
  def to_csv(student = nil)
    tags_list = ""
    tags.each do |tag|
      tags_list += tag.name
      tags_list += ", " unless tag == tags.last
    end
    if(student)
      return [self.created_at.strftime("%Y-%m-%d %I:%M %p"),"",student.last_name, student.first_name,self.summary,self.counselor.formal_name,tags_list,self.notes].to_csv
    elsif groups.count == 1 
      return [ self.created_at.strftime("%Y-%m-%d %I:%M %p"),self.groups.first.name,"","",self.summary,self.counselor.formal_name,tags_list,self.notes].to_csv 
    elsif students.count == 1
      return [self.created_at.strftime("%Y-%m-%d %I:%M %p"),"",self.students.first.last_name, self.students.first.first_name,self.summary,self.counselor.formal_name,tags_list,self.notes].to_csv
    end 
  end
end
