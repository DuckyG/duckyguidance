class CounselorSessionsController < ApplicationController
  def new
    @counselor_session = CounselorSession.new
    @title = 'Login'
  end

  def create
    @counselor_session = CounselorSession.new(params[:counselor_session])
    if @counselor_session.save
      flash[:notice] = "Login successful!"
      redirect_to dashboard_url
    else
      render :action => :new
    end
  end

  def destroy
    @counselor_session = CounselorSession.find
    @counselor_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to root_url
  end

end
