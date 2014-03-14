source "https://rubygems.org"
ruby "2.0.0"

gem "bcrypt-ruby", "~> 3.0.0"
gem "coffee-rails", "~> 4.0.0"
gem "jbuilder", "~> 1.2"
gem "jquery-rails"
gem "pg", "~> 0.17.0"
gem "rails", "~> 4.0.3"
gem "sass-rails", "~> 4.0.0"
gem "turbolinks"
gem "unicorn", "~> 4.8.2"
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "rspec-rails", "~> 2.14.1"
  gem "factory_girl_rails", "~> 4.4.1"
end

group :test do
  gem 'capybara', '~> 2.2'
  gem 'selenium-webdriver', '~> 2.33'
  gem 'faker', '~> 1.3.0'
  gem 'launchy', '~> 2.4.0'
  gem 'database_cleaner', '~> 1.2.0'
end

group :production do
  gem "rails_12factor", "~> 0.0.2"
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem "sdoc", require: false
end
