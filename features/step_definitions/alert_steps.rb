Then /^I should see an alert stating "([^"]*)"$/ do |alert_text|
  page.has_css?(".accountAlert.error p", text: alert_text).should be_true
end

