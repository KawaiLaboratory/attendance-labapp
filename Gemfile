source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'rails', '~> 5.2.2'
gem 'puma'
gem 'sass-rails'
gem 'uglifier'
gem 'mini_racer', platforms: :ruby
gem 'coffee-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'bcrypt'
gem 'bootsnap', require: false
gem 'slim-rails'
gem "jquery-rails"
gem 'bootstrap-sass'
gem "bootswatch-rails"
gem "font-awesome-rails"
gem "cocoon"
gem 'rails-i18n'
gem 'enum_help'
gem "devise"
gem "devise-i18n"
gem "devise-i18n-views"
gem "devise-bootstrap-views"
gem "jpmobile"
gem "chartkick"
gem 'fiscali'
gem 'data-confirm-modal'
gem "actionview"
gem 'fullcalendar-rails'
gem 'momentjs-rails'
gem 'slack-notifier'
gem "activesupport"
gem "actionpack"
gem "activestorage"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'mysql2'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-doc'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console'
  gem 'listen'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'bullet'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

group :production do
  gem "pg"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
