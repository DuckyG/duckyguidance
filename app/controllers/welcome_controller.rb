class WelcomeController < ApplicationController
  layout false
  access_control do
    allow all
  end
  def index
    @user_session = UserSession.new
    
    if current_user
      redirect_to dashboard_path
    end
  end
  


end
