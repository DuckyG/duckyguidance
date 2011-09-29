When /^I select "([^"]*)" for the "([^"]*)" field$/ do |value, field|
  select(value, from: field)
end

When /^I enter "([^"]*)" for the "([^"]*)" field$/ do |value, field|
  fill_in(field, with: value)
end

