class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  before_filter :require_counselor, :check_domain, :ensure_defaults
  helper_method :current_school, :current_user_session, :current_user

  private
    def check_domain
      if request.subdomains.first != nil && !current_school
        querystring = "?error_domain="+ request.subdomains.first
        querystring = querystring + "&error_title=School+Not+Found"
        querystring = querystring + "&error_message=The+school+you+are+looking+for+could+not+be+found.+Please+check+to+see+that+you+have+the+correct+domain+for+your+school."


        redirect_to request.scheme+"://" + request.domain+"/error/404"+querystring
      end
    end
    
    def ensure_defaults
      # This is a workaraound, this should be removed once a "Create site" flow and un-deletable defaults are added
      if current_school
       
      end
    end
    
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    def current_school
      return @current_school if defined?(@current_school)
      @current_school = School.find_by_subdomain(request.subdomains.first)
    end

    def current_counselor
      return @current_counselor if defined?(@current_counselor)
      @current_counselor = Counselor.find(current_user.id) 
    end
    def require_counselor
      unless current_user
        flash[:notice] = "You must be logged in to access this page"
        redirect_to login_url
        return false
      end
      
      unless current_user.school_id == current_school.id
        flash[:notice] = "You do not have access to this school"
        current_user_session.destroy
        redirect_to login_url
        return false
      end
    end

    def require_no_counselor
      if current_user
        flash[:notice] = "You must be logged out to access this page"
        redirect_to root_url
        return false
      end
    end
end
