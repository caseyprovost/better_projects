source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.5"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 6.0.2", ">= 6.0.2.2"
# Use postgresql as the database for Active Record
gem "pg", ">= 0.18", "< 2.0"
# Use Puma as the app server
gem "puma", "~> 4.1"
# Use SCSS for stylesheets
gem "sass-rails", ">= 6"
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem "webpacker", "~> 4.0"

gem 'jbuilder', '~> 2.7'

gem "inertia_rails"
gem "devise"
gem "sidekiq"
gem "interactor"
gem "pundit"
gem "pagy"

# Use Active Storage variant
gem "image_processing", "~> 1.2"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.2", require: false

group :development, :test do
  gem "pry-rails"
  gem "faker"
  gem "factory_bot_rails"
  gem "standard"
  gem "minitest-rails"
end

group :test do
  gem "capybara"
  gem "cuprite"
  gem "minitest-reporters"
  gem "mocha"
  gem 'ruby-prof'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "web-console"
  gem "listen"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen"
  gem "spring-commands-rspec"
  gem "guard", github: "caseyprovost/guard"
  gem "guard-bundler",           "~> 2.1"   # Update and install gems when necessary
  gem "guard-livereload",        "~> 2.5"   # Reload the browser when view files change
  gem "guard-process",           "~> 1.2"   # Run arbitrary processes from Guardfile
  gem "guard-rails",             "~> 0.8"   # Start and restart Rails server when necessary
  gem "guard-sidekiq",           "~> 0.1"   # Monitor Rails sidekiq process intelligently
  gem 'guard-minitest'
  gem 'js-routes', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
