class UserSessionsController < ApplicationController
  access_control do
      allow all
  end
  def new
    @user_session = UserSession.new
    @title = 'Login'
  end

  def create
    
    @user_session = UserSession.new(params[:user_session])
    
    user = User.find_by_email params[:user_session][:email]
    if !user.has_role? :member, current_subdomain
      @user_session.errors.add :base, "You do not have access to this domain"
    end
    
    if user.has_role?(:member, current_subdomain) && @user_session.save
      if admin_domain
        redirect_to schools_path
      else
        redirect_to dashboard_path
      end
    else
      render :action => :new
    end
  end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "You have logged out."
    redirect_to root_url
  end

end
