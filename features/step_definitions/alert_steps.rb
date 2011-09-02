Then /^I should see an alert stating "([^"]*)"$/ do |alert_text|
  page.has_css?(".accountAlert p", text: alert_text)
end

