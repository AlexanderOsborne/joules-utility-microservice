source "https://rubygems.org"
ruby "2.5.3"

gem 'sinatra', require: 'sinatra/base'
gem 'shotgun'
gem 'faraday'
gem 'puma'
gem 'require_all'

group :test do
  gem "rspec"
  gem 'pry'
end

group :development, :test do
  gem 'capybara'
  gem 'launchy'
  gem 'simplecov'
  gem 'pry'
  gem 'figaro', git: 'https://github.com/bpaquet/figaro.git', branch: 'sinatra'
end