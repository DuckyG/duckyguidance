class WelcomeController < ApplicationController
  layout 'logged_out'
  access_control do
    allow all
    allow :superadmin
  end
  def index
    @sectionName = "Request a Meeting"
    @user_session = UserSession.new
    
    if current_user
      redirect_to dashboard_path
    end
  end
  


end
