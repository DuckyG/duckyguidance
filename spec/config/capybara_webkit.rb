require 'capybara/rspec'

RSpec.configure do |config|
  config.before(:suite) do
    Capybara.server_port = 3999
    Capybara.app_host = "http://integration.ducky.test:3999"
    Capybara.default_host = "integration.ducky.test"
    Capybara.javascript_driver = :webkit
  end
end
