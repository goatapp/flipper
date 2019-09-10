source 'https://rubygems.org'
gemspec name: 'flipper'

Dir['flipper-*.gemspec'].each do |gemspec|
  plugin = gemspec.scan(/flipper-(.*)\.gemspec/).flatten.first
  gemspec(name: "flipper-#{plugin}", development_group: plugin)
end

gem 'pry'
gem 'rake', '~> 10.4.2'
gem 'shotgun', '~> 0.9'
gem 'statsd-ruby', '~> 1.2.1'
gem 'rspec', '~> 3.0'
gem 'rack-test', '~> 0.6.3'
gem 'sqlite3', "~> #{ENV['SQLITE3_VERSION'] || '1.3.11'}"
gem 'rails', "~> #{ENV['RAILS_VERSION'] || '5.1.4'}"
gem 'minitest', '~> 5.8.0'
gem 'rubocop', '~> 0.45.0'
gem 'rubocop-rspec', '= 1.5.1'
gem 'webmock', '~> 2.0'

gem 'honeycomb-beeline', '~> 1.0' # https://github.com/bugsnag/bugsnag-ruby/issues/556

# for active support tests in test/ and only needed for ruby 2.2.x
gem 'test-unit', '~> 3.0'

group(:guard) do
  gem 'guard', '~> 2.12.5'
  gem 'guard-rubocop', '~> 1.3.0'
  gem 'guard-rspec', '~> 4.5.0'
  gem 'guard-bundler', '~> 2.1.0'
  gem 'guard-coffeescript', '~> 2.0.1'
  gem 'guard-sass', '~> 1.6.0'
  gem 'rb-fsevent', '~> 0.9.4'
end
