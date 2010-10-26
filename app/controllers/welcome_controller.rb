class WelcomeController < ApplicationController
  skip_before_filter :require_counselor
  def index
    @counselor_session = UserSession.new
    
    if current_user
      redirect_to dashboard_path
    end
  end
  


end
