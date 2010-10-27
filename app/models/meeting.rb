class Meeting < ActiveRecord::Base
  belongs_to :student
  belongs_to :counselor
  attr_accessor :date, :start_time, :end_time, :tags_string
  validates :student, :counselor, :occured_on, :notes, :summary, :category, :presence => true 
  before_validation :convert_meta
  has_many :meeting_tags
  has_many :tags, :through => :meeting_tags
  belongs_to :category
  belongs_to :school
  
  def get_duration
    Time.parse(@end_time) - Time.parse(@start_time) 
  end
  
  def get_occured_on
    @date + " " + @start_time
  end
  
  def get_tag_string
    arr = []
    tags.each {|tag| arr.push tag.name}
    arr.join ' '
  end
  
  def occured_on_or_now
    return occured_on if occured_on
    return DateTime.now
  end
  
  
  def duration_hours_min
    minutes = 0
    hours = 0
    if duration
      minutes = duration/60
      hours = minutes/60
    end
    return hours,minutes%60
  end
  
  def end_time
    if duration
      occured_on_or_now + duration
    else
      occured_on_or_now + 900
    end
  end
  
  def convert_meta
    self.occured_on = Date.strptime get_occured_on, "%m/%d/%Y %I:%M %p" 
    self.duration = get_duration
    get_tags if @tags_string
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
