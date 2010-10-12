class CounselorSessionsController < ApplicationController
  skip_before_filter :require_counselor
  def new
    @counselor_session = CounselorSession.new
    @title = 'Login'
  end

  def create
    @counselor_session = CounselorSession.new(params[:counselor_session])
    if @counselor_session.save
      redirect_to dashboard_path
    else
      render :action => :new
    end
  end

  def destroy
    @counselor_session = CounselorSession.find
    @counselor_session.destroy
    flash[:notice] = "You have logged out."
    redirect_to root_url
  end

end
