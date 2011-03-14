class ThankyouController < ApplicationController
  layout false
  access_control do
    allow all
  end
  def index
    @section = 'Thank You'
  end
  
end
