RSpec::Core::RakeTask.new(:rspec_html) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.rspec_opts = '--format html'
end
