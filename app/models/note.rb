class Note < ActiveRecord::Base
  belongs_to :student
  belongs_to :counselor
  belongs_to :category
  belongs_to :school
  attr_accessor :date, :start_time, :end_time, :tags_string
  validates :student, :counselor, :notes, :summary, :category, :presence => true 
  before_validation :convert_meta
  
  has_and_belongs_to_many :tags

  def get_tag_string
    arr = []
    tags.each {|tag| arr.push tag.name}
    arr.join ' '
  end

  
  def convert_meta
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
