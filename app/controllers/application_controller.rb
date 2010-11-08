class ApplicationController < ActionController::Base
  rescue_from 'Acl9::AccessDenied', :with => :access_denied
  protect_from_forgery
  layout 'application'
  before_filter :check_domain
  helper_method :current_school, :current_user_session, :current_user, :current_subdomain, :current_counselor
  
  private
    def access_denied
      if current_user
        if current_user.has_role? :member, current_subdomain
          flash[:notice] = "You do not have access to this page"
          redirect_to dashboard_path
        else
          current_user_session.destroy
          flash[:notice] = "You do not have access to this domain"
          redirect_to root_path
        end
      else
        flash[:notice] = "You must be logged in to view this page"
        redirect_to root_path
      end
    end
    
    def check_domain
      if !request.subdomains.empty? && !current_subdomain
        querystring = "?error_domain="+ request.subdomains.first
        querystring = querystring + "&error_title=School+Not+Found"
        querystring = querystring + "&error_message=The+school+you+are+looking+for+could+not+be+found.+Please+check+to+see+that+you+have+the+correct+domain+for+your+school."

        redirect_to request.scheme+"://" + request.domain+"/error/404"+querystring
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
      @current_school = current_subdomain ? current_subdomain.school : nil
      
    end
    
    def current_subdomain
      return @current_subdomain if defined?(@current_subdomain)
      @current_subdomain = Subdomain.find_by_name(request.subdomains.first)
    end

    def current_counselor
      return @current_counselor if defined?(@current_counselor)
      @current_counselor = current_user ? Counselor.find(current_user.id) : nil
    end
end
