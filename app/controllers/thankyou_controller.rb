class ThankyouController < ApplicationController
  access_control do
    allow all
  end
  def index
    @title = 'Thank You'
  end
  
end
