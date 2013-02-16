# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/config/**/*.rb")].each {|f| require f}
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
Dir[Rails.root.join('spec/requests/step_helpers/**/*.rb')].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  config.include FactoryGirl::Syntax::Methods
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.strategy = :deletion
    t = Time.local(2011, 9, 1, 10, 0, 0)
    Timecop.travel(t)
  end

  config.before(:each) do
    DatabaseCleaner.clean
    DatabaseCleaner.start
    @school = create :school, :subdomain => create(:subdomain)
    Capybara.default_host = "http://#{@school.subdomain.name}.ducky.local"
  end

  config.after(:suite) do
    Timecop.return
  end
end
