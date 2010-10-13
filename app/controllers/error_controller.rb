class ErrorController < ApplicationController
  skip_before_filter :require_counselor, :check_domain
  def show
    if params['error_message']
      flash['error_message'] = params['error_message']
      flash['error_title'] = params['error_title']
      flash['error_domain'] = params['error_domain']
      redirect_to "/error/404"
    end
    if flash['error_title']
      @title = flash['error_title']
    end
  end

end
