class WelcomeController < ApplicationController
  access_control do
    allow all
    allow :superadmin
  end
  def index
    @user_session = UserSession.new
    
    if current_user
      redirect_to dashboard_path
    end
  end
  


end
