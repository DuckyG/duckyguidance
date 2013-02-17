require 'spec_helper'

feature 'Logging in' do
  scenario 'Valid credentials' do
    log_in_as create(:counselor, :school => @school)
    current_path.should eq '/dashboard'
  end
end
