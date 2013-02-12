class Note < ActiveRecord::Base
  has_and_belongs_to_many :students
  has_and_belongs_to_many :groups
  has_and_belongs_to_many :smart_groups
  belongs_to :counselor, class_name: "User"
  belongs_to :category
  belongs_to :school
  attr_accessor :notify_students_counselor, :tags_string, :student_ids, :group_ids, :smart_group_ids
  attr_accessible :student_ids, :group_ids, :notes, :category_id, :summary, :occurred_on, :smart_group_ids, :tags_string, :confidentiality_level
  validates :counselor, :notes, :summary, :category, :presence => true
  before_validation :convert_meta
  before_validation { self.school = self.counselor.school }
  has_and_belongs_to_many :tags
  default_scope :order => '"notes".occurred_on DESC'

  before_destroy { self.students.clear }
  before_destroy { self.groups.clear }

  ConfidentialityLevels = [["All Counselors","department"],["Director and me","director"]]
  class << self
    def unassigned
      joins("left join notes_students on notes_students.note_id = notes.id").where("notes_students.note_id is null")
    end

    def confidentiality_levels
      ConfidentialityLevels
    end
  end

  def formatted_date_and_time
    occurred_on.strftime '%B %d %Y' if occurred_on
  end

  def numeric_date_and_time
    occurred_on.strftime '%m/%d/%Y' if occurred_on
  end

  def get_tag_string
    arr = []
    tags.each {|tag| arr.push tag.name}
    arr.join ' '
  end

  def subject_name
    return "Group: #{groups.first.name}" unless groups.first.nil?
    return "Smart Group: #{smart_groups.first.name}" unless smart_groups.first.nil?
    return students.first.full_name if students.count == 1
    return "Unassigned" if students.count == 0
    return "Multiple students"
  end

  def subject
    return groups.first unless groups.first.nil?
    return smart_groups.first unless smart_groups.first.nil?
    return students.first if students.count == 1
    return "#" if students.count == 0
    return students
  end
  
  def subject_path
  	note.subject == note.students ? note_students_path(note) : note.subject
  end

  def convert_meta
    get_tags if @tags_string
    convert_student_ids
    convert_group_ids
    convert_smart_group_ids
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

  def convert_smart_group_ids
    unless @smart_group_ids.nil?
      @smart_group_ids.split(',').each do |id|
        smart_group = school.smart_groups.find id
        students_to_append = smart_group.students - self.students
        self.students<< students_to_append
        self.smart_groups << smart_group
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
