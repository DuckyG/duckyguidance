class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  before_filter :require_counselor, :check_domain, :ensure_defaults
  helper_method :current_counselor_session, :current_counselor, :current_school

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
      uncat_cat =current_school.categories.find_by_name "Uncategorized"
      if !uncat_cat
        uncat_cat = Category.new
        uncat_cat.name = "Uncategorized"
        uncat_cat.school = current_school
        uncat_cat.save
      end
    end
    def current_counselor_session
      return @current_counselor_session if defined?(@current_counselor_session)
      @current_counselor_session = CounselorSession.find
    end

    def current_counselor
      return @current_counselor if defined?(@current_counselor)
      @current_counselor = current_counselor_session && current_counselor_session.record
    end
    
    def current_school
      return @current_school if defined?(@current_school)
      @current_school = School.find_by_subdomain(request.subdomains.first)
    end

    def require_counselor
      unless current_counselor
        flash[:notice] = "You must be logged in to access this page"
        redirect_to login_url
        return false
      end
      
      unless current_counselor.school_id == current_school.id
        flash[:notice] = "You do not have access to this school"
        current_counselor_session.destroy
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
