class Meeting < ActiveRecord::Base
  belongs_to :student
  belongs_to :counselor
  attr_accessor :date, :start_time, :end_time, :tags_string
  validates :student, :counselor, :occured_on, :notes, :summary, :presence => true 
  before_save :convert_meta
  has_many :meeting_tags
  has_many :tags, :through => :meeting_tags
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
      occured_on + duration
    else
      occured_on + 900
    end
  end
  
  def convert_meta
    self.occured_on = get_occured_on
    self.duration = get_duration
    get_tags
  end

  def get_tags
    tag_list = @tags_string.split ' '
    tag_array = []
    tag_list.each do |tag_str|
      if !tag_str.strip.empty?
        tag = Tag.find_by_name tag_str.downcase
        if !tag
          tag = Tag.new
          tag.name = tag_str.downcase
          tag.save!
        end
        tag_array.push tag 
      end
    end
    self.tags = tag_array
  end
  
end
