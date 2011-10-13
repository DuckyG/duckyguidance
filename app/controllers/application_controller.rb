class ApplicationController < ActionController::Base
  ActionView::Base.field_error_proc = proc { |input, instance| input }
  rescue_from 'Acl9::AccessDenied', :with => :access_denied
  protect_from_forgery

  layout 'standard'
  before_filter :check_domain, :check_defaults, :check_smart_group
  helper_method :current_school, :current_user, :current_subdomain, :build_student_options, :render_csv, :current_school_year, :warning
  before_filter :mailer_set_url_options
  
  layout :layout_by_resource

  private

  #Provides warning method to get flash[:warning]. Method alredy exists for :notice and :error
  def warning
    @warning ||= flash[:warning]
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || dashboard_path
  end

  def mailer_set_url_options
    ActionMailer::Base.default_url_options[:host] = request.host
  end

  def current_user
      return @current_user if defined?(@current_user)
      if current_counselor
        @current_user = User.find(current_counselor.id)
      else
        @current_user = User.new
      end
  end
  def access_denied
      if current_counselor
        if current_counselor.has_role? :member, current_subdomain
          flash[:notice] = "You do not have access to this page"
          redirect_to dashboard_path
        else

          flash[:notice] = "You do not have access to this domain"
          redirect_to login_path
        end
      else
        flash[:notice] = "You must be logged in to view this page"
        redirect_to login_path
      end
    end

    def check_defaults
      if current_school
        uncat = current_school.categories.find_by_name 'Uncategorized'
        unless uncat
          uncat = Category.new
          uncat.name = "Uncategorized"
          uncat.description = "System category: Uncategorized"
          uncat.system = true
          uncat.school = current_school
          uncat.save
        end
      end
    end

    def check_domain
      if !request.subdomains.empty? && !current_subdomain
        @section = "School Not Found"
        @message = "The school you are looking for could not be found. Please check to see that you have the correct domain for your school."
        render "shared/error", :status => 404, :layout => false
      end
    end

    def build_student_options(student_list, selected_students)
      output = ""
      student_list.sort! {|x,y| x.last_name <=> y.last_name}
      student_list.each do |student|
        output += "<option value='#{student.id}' #{'selected="selected"' if selected_students.include? student}>#{student.last_name}, #{student.first_name}</option>"
      end
      output.html_safe
    end

    def current_school
      return @current_school if defined?(@current_school)
      @current_school = current_subdomain ? current_subdomain.school : nil
    end

    def current_subdomain
      return @current_subdomain if defined?(@current_subdomain)
      @current_subdomain = Subdomain.find_by_name(request.subdomains.first)
    end



    def render_csv(filename = nil)
      filename ||= params[:action]
      filename += '.csv'

      if request.env['HTTP_USER_AGENT'] =~ /msie/i
        headers['Pragma'] = 'public'
        headers["Content-type"] = "text/plain" 
        headers['Cache-Control'] = 'no-cache, must-revalidate, post-check=0, pre-check=0'
        headers['Content-Disposition'] = "attachment; filename=\"#{filename}\"" 
        headers['Expires'] = "0" 
      else
        headers["Content-Type"] ||= 'text/csv'
        headers["Content-Disposition"] = "attachment; filename=\"#{filename}\"" 
      end

      render :layout => false
    end

    def check_smart_group
      if current_counselor
        unless current_school.smart_groups.find_by_field_name_and_field_value("counselor_id", current_counselor.id.to_s)
          smart_group = SmartGroup.new
          smart_group.name = "#{current_counselor.formal_name}'s students"
          smart_group.field_name = "counselor_id"
          smart_group.field_value = current_counselor.id.to_s
          smart_group.school = current_school
          smart_group.save
        end
      end
    end

    
  def layout_by_resource
    devise_controller? ? 'logged_out' : 'standard'
  end
end
