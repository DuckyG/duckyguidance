class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  
  helper_method :current_counselor_session, :current_counselor

  private
    def current_counselor_session
      return @current_counselor_session if defined?(@current_counselor_session)
      @current_counselor_session = CounselorSession.find
    end

    def current_counselor
      return @current_counselor if defined?(@current_counselor)
      @current_counselor = current_counselor_session && current_counselor_session.record
    end

    def require_counselor
      unless current_counselor
        flash[:notice] = "You must be logged in to access this page"
        redirect_to login_url
        return false
      end
    end

    def require_no_counselor
      if current_counselor
        flash[:notice] = "You must be logged out to access this page"
        redirect_to root_url
        return false
      end
    end
end
