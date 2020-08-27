source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.1"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 6.0"
# Use postgresql as the database for Active Record
gem "pg", ">= 0.18", "< 2.0"
# Use Puma as the app server
gem "puma", "~> 4.3"
# Use SCSS for stylesheets
gem "sass-rails", ">= 6"
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem "webpacker", "~> 5.0"

gem "inertia_rails"
gem "devise"
gem "interactor"
gem "pundit"
gem "pagy"
gem "amoeba"
gem "m"
gem "rack-cors"
gem "paper_trail"
gem "sidekiq"

# Use Active Storage variant
gem "image_processing", "~> 1.2"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.2", require: false

group :development, :test do
  gem "pry-rails"
  gem "pry-byebug"
  gem "pry-doc"
  gem "faker"
  gem "factory_bot_rails"
  gem "standard"
end

group :test do
  gem "capybara"
  gem "cuprite"
  gem "minitest-reporters"
  gem "mocha"
  gem "ruby-prof"
  gem "selenium-webdriver"
  gem "database_cleaner-active_record"
  gem "database_cleaner-redis"
  gem "policy-assertions"
  # TODO: not yet rails-edge compatible
  gem "minitest-rails"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "web-console"
  gem "listen"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen"
  gem "spring-commands-rspec"
  gem "guard"
  gem "guard-minitest"
  gem "guard-bundler", "~> 2.1" # Update and install gems when necessary
  gem "guard-livereload", "~> 2.5" # Reload the browser when view files change
  gem "guard-process", "~> 1.2" # Run arbitrary processes from Guardfile
  gem "guard-rails", "~> 0.8" # Start and restart Rails server when necessary
  gem "guard-sidekiq", "~> 0.1" # Monitor Rails sidekiq process intelligently
  gem "js-routes", require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
