class WelcomeController < ApplicationController
  skip_before_filter :require_counselor
  def index
    @counselor_session = CounselorSession.new
  end

end
