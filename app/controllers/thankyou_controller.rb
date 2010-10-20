class ThankyouController < ApplicationController
  skip_before_filter :require_counselor
  def index
    @title = 'Thank You'
  end
  
end
