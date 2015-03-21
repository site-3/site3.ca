source 'https://rubygems.org'
ruby '2.2.0'

gem 'rails', '4.2.1.rc4'

# Front-end stuff
gem 'sass-rails', '~> 5.0'
gem 'compass-rails'
gem 'jquery-rails'
gem 'bootstrap-sass'
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails', '~> 4.1.0' # Use CoffeeScript for .coffee assets and views
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

gem 'haml'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'devise' # handles registration, sessions and more
gem 'bcrypt', '~> 3.1.7'
gem 'paper_trail' # Version everything!
gem 'turbolinks'
gem 'unicorn'
gem 'jbuilder', '~> 2.0'

# Make stripe payments for the vending machine
gem 'stripe', :git => 'https://github.com/stripe/stripe-ruby'

group :development, :test do
  gem 'sqlite3'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # fake data!
  gem 'factory_girl_rails'
  gem 'faker'

  # rspec!
  gem 'rspec-rails'
  gem 'rspec-its'
  gem 'guard-rspec'
end

group :test do
  gem 'database_cleaner'
  gem 'stripe-ruby-mock', '~> 2.1.0', :require => 'stripe_mock'
end

group :production do
  # Use postgres on heroku
  gem 'pg'
  gem 'rails_12factor'
end
