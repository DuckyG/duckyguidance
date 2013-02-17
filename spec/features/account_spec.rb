require 'spec_helper'

feature 'Managing my account' do
  scenario 'Updating a password with a valid password' do
    counselor = log_in_as create(:counselor, :school => @school)
    click_link counselor.first_name

    fill_in 'user_password', :with => 'differentPassword2'
    fill_in 'Confirm Your New Password', :with => 'differentPassword2'

    click_button 'Save Your Changes'

    click_link 'Sign Off'

    log_in_as counselor, 'differentPassword2'
    current_path.should eq '/dashboard'
  end
end
