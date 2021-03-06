source 'https://rubygems.org'
ruby '2.3.0'

gem 'rails', '~> 5'

# Front-end stuff
gem 'sass-rails'
gem 'compass-rails'
gem 'jquery-rails'
gem 'bootstrap-sass'
gem 'font-awesome-rails'
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails' # Use CoffeeScript for .coffee assets and views
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

gem 'jbuilder'

gem 'haml'
gem 'devise' # Handles registration, sessions and more
gem 'omniauth-facebook'

gem 'paper_trail' # Version everything!

# Make stripe payments for the vending machine
gem 'stripe', '<= 1.43'

group :development, :test do
  gem 'sqlite3'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # fake data!
  gem 'factory_girl_rails'
  gem 'faker'

  # rspec!
  gem 'rspec-rails'
  gem 'rspec-its'
  gem 'guard-rspec'
  gem 'rails-controller-testing'

  gem 'rubocop', require: false
  gem 'bundler-audit', require: false

  gem 'pry'
end

group :development do
  gem 'letter_opener'
end

group :test do
  gem 'database_cleaner'
  gem 'stripe-ruby-mock', '~> 2.3.0', require: 'stripe_mock'
  gem 'rspec_junit_formatter', git: 'git@github.com:circleci/rspec_junit_formatter.git'
end

group :production do
  # Use postgres on heroku
  gem 'pg'
  gem 'rails_12factor'
end
