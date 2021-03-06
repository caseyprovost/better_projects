# test/test_helper.rb

ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require_relative "../config/environment"
require "rails/test_help"
require "minitest/rails"
require "mocha/minitest"
require "policy_assertions"

require "sidekiq/testing"
Sidekiq::Testing.inline!

# Improved Minitest output (color and progress bar)
require "minitest/reporters"
Minitest::Reporters.use!(
  Minitest::Reporters::ProgressReporter.new,
  ENV,
  Minitest.backtrace_filter
)

Dir[Rails.root.join("test", "support", "**", "*.rb")].sort.each { |f| require f }

unless Webpacker.compiler.fresh?
  puts "== Webpack compiling =="
  Webpacker.compiler.compile
  puts "== Webpack compiled =="
end

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  include Devise::Test::IntegrationHelpers
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end

class ActionController::TestCase
  include Devise::Test::ControllerHelpers
end
