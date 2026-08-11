source 'https://rubygems.org'
gemspec name: 'flipper'

Dir['flipper-*.gemspec'].each do |gemspec|
  plugin = gemspec.scan(/flipper-(.*)\.gemspec/).flatten.first
  gemspec(name: "flipper-#{plugin}", development_group: plugin)
end

gem 'debug'
gem 'rake', '~> 12.3.3'
gem 'statsd-ruby', '~> 1.2.1'
gem 'rspec', '~> 3.0'
gem 'rack-test'
# Rack major is selectable so CI can prove flipper-ui works on both 2.x and 3.x.
gem 'rack', "~> #{ENV['RACK_VERSION'] || '2.2'}"
# Rack 3 moved Rack::Session::Cookie out of rack into the rack-session gem.
gem 'rack-session' if (ENV['RACK_VERSION'] || '2.2').start_with?('3')
gem 'sqlite3', "~> #{ENV['SQLITE3_VERSION'] || '1.7'}"
gem 'rails', "~> #{ENV['RAILS_VERSION'] || '7.1.0'}"
gem 'minitest', '~> 5.18'
gem 'minitest-documentation'
gem 'webmock', '~> 3.0'
gem 'ice_age'
gem 'redis-namespace'
gem 'webrick'
gem 'stackprof'
gem 'benchmark-ips'
gem 'stackprof-webnav'
gem 'flamegraph'

group(:guard) do
  gem 'guard', '~> 2.15'
  gem 'guard-rspec', '~> 4.5'
  gem 'guard-bundler', '~> 2.2'
  gem 'rb-fsevent', '~> 0.9'
end
