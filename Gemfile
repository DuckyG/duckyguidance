source 'http://rubygems.org'

gem 'rails', '3.2.16'
gem 'cancan'
gem 'devise', '1.5.4'
gem 'bundler'

gem 'pg'
gem 'kaminari'
gem 'foreigner'
#gem 'delayed_job', :tag => 'v2.1.4', :git => 'https://github.com/collectiveidea/delayed_job.git'
group :production do
  gem 'newrelic_rpm'
  gem 'lograge'
end

# Deploy with Capistrano
gem 'capistrano'
gem 'capistrano-ext'

gem 'squeel'
gem 'exception_notification'
gem 'thin'
gem 'foreman'
group :development, :test do
  gem 'brakeman'
  gem 'rspec-rails'
  gem 'debugger'
  gem "factory_girl_rails"
end

group :test do
  gem 'launchy'
  gem 'timecop', '~> 0.5.8'
  gem 'valid_attribute'
  gem 'capybara-webkit'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem 'capybara'
end
