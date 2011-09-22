# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Guidance::Application.initialize!

RAILS_DEFAULT_LOGGER ||= Logger.new("#{RAILS_ROOT}/log/#{RAILS_ENV}.log")
