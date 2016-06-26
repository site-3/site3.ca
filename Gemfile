source 'https://rubygems.org'
ruby '2.3.0'

gem 'rails', '4.2.6'

# Front-end stuff
gem 'sass-rails', '~> 5.0'
gem 'compass-rails'
gem 'jquery-rails'
gem 'bootstrap-sass'
gem 'font-awesome-rails'
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails', '~> 4.1.0' # Use CoffeeScript for .coffee assets and views
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

gem 'jbuilder'

gem 'haml'
gem 'devise' # Handles registration, sessions and more
gem 'omniauth-facebook'

gem 'paper_trail' # Version everything!

# Make stripe payments for the vending machine
gem 'stripe', git: 'https://github.com/stripe/stripe-ruby'

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

  gem 'rubocop', require: false

  gem 'pry'
end

group :development do
  gem 'letter_opener'
end

group :test do
  gem 'database_cleaner'
  gem 'stripe-ruby-mock', '~> 2.1.0', require: 'stripe_mock'
  gem 'rspec_junit_formatter', git: 'git@github.com:circleci/rspec_junit_formatter.git'
end

group :production do
  # Use postgres on heroku
  gem 'pg'
  gem 'rails_12factor'
end
