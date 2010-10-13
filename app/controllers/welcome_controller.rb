class WelcomeController < ApplicationController
  skip_before_filter :require_counselor
  def index
    @counselor_session = CounselorSession.new
    
    if current_counselor
      redirect_to dashboard_path
    end
  end
  


end
