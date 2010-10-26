class CounselorSessionsController < ApplicationController
  skip_before_filter :require_counselor
  def new
    @counselor_session = UserSession.new
    @title = 'Login'
  end

  def create
    @counselor_session = UserSession.new(params[:user_session])
    if @counselor_session.save
      redirect_to dashboard_path
    else
      render :action => :new
    end
  end

  def destroy
    @counselor_session = UserSession.find
    @counselor_session.destroy
    flash[:notice] = "You have logged out."
    redirect_to root_url
  end

end
