def log_in_as(counselor, password = nil)
  visit '/'

  fill_in 'Email Address', :with => counselor.email
  fill_in 'Password', :with => password || counselor.password
  click_button 'Login'

  counselor
end
