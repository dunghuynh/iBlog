source 'http://rubygems.org'

gem 'rails', '3.1.1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'twitter-bootstrap-rails'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'


# Database

# gem 'sqlite3', :group => [:development, :test]
gem 'mysql2', :group => [:development, :test]
gem 'pg', :group => :production
# Problem with mysql solution: 
# sudo install_name_tool -change libmysqlclient.18.dylib /usr/local/mysql/lib/libmysqlclient.18.dylib /Users/huynh/.rvm/gems/ruby-1.9.2-p290\@rails311/gems/mysql2-0.3.7/lib/mysql2/mysql2.bundle


gem 'devise'
gem 'pg' # This is the extension library to access a PostgreSQL database from Ruby
gem 'coffee-filter'

group :production do
  gem 'therubyracer'
end


group :development, :test do
  gem 'rspec-rails'
  gem 'haml-rails'  # to use haml instead of erb
  gem 'pickle' # Easy model creation and reference in your cucumber features
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'awesome_print'
  gem 'populator'
  gem 'faker'
end

group :test do
  gem 'cucumber-rails'
  gem 'capybara'
  gem 'launchy' # save_and_open_page
  gem 'shoulda-matchers'
  gem 'database_cleaner'
  gem 'machinist', '>= 2.0.0.beta2' # makes it easy to create objects for use in tests. It generates data for the attributes you don't care aboutmakes it easy to create objects for use in tests. It generates data for the attributes you don't care about
  gem 'capybara-webkit'

  gem 'spork', '~> 0.9.0.rc9'
  gem 'rb-fsevent'
  gem 'guard'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'ruby_gntp' # growl notifier
end
