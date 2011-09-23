class UserSessionsController < ApplicationController
  ActionView::Base.field_error_proc = proc { |input, instance| input }
  layout 'logged_out'
  access_control do
      allow all
  end
  def new
    @user_session = UserSession.new
    @sectionName = "Counselor Login"
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      if current_subdomain.name == 'admin'
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
    redirect_to login_path
  end

end
