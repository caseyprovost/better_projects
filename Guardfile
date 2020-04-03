# frozen_string_literal: true

guard :bundler do
  require "guard/bundler"
  require "guard/bundler/verify"
  helper = Guard::Bundler::Verify.new

  files = ["Gemfile"]

  # Assume files are symlinked from somewhere
  files.each { |file| watch(helper.real_path(file)) }
end

guard :process, name: "Docker Compose", command: "docker-compose up" do
  watch("docker-compose.yml")
end

guard :process, name: "Webpack Dev Server", command: "./bin/webpack-dev-server" do
  watch("config/webpacker.yml")
  watch("app/javascript/packs/application.js")
end

guard :sidekiq, environment: "development", queue: %w[default] do
  watch(%r{^workers/(.+)\.rb$})
end

guard "livereload" do
  extensions = {
    css: :css,
    scss: :css,
    sass: :css,
    html: :html,
    png: :png,
    gif: :gif,
    jpg: :jpg,
    jpeg: :jpeg
  }

  rails_view_exts = %w[erb]

  # file types LiveReload may optimize refresh for
  compiled_exts = extensions.values.uniq
  watch(%r{public/.+\.(#{compiled_exts * '|'})})

  extensions.each do |ext, type|
    watch(%r{
          (?:app|vendor)
          (?:/assets/\w+/(?<path>[^.]+) # path+base without extension
           (?<ext>\.#{ext})) # matching extension (must be first encountered)
          (?:\.\w+|$) # other extensions
          }x) do |m|
      path = m[1]
      "/assets/#{path}.#{type}"
    end
  end

  # file needing a full reload of the page anyway
  watch(%r{app/views/.+\.(#{rails_view_exts * '|'})$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{config/locales/.+\.yml})
end

guard :minitest, spring: false do
  watch(%r{^app/(.+)\.rb$}) { |m| "test/#{m[1]}_test.rb" }
  watch(%r{^app/controllers/application_controller\.rb$}) { "test/controllers" }
  watch(%r{^app/controllers/(.+)_controller\.rb$}) { |m| "test/integration/#{m[1]}_test.rb" }
  watch(%r{^app/views/(.+)_mailer/.+}) { |m| "test/mailers/#{m[1]}_mailer_test.rb" }
  watch(%r{^app/jobs/(.+)\.rb$}) { |m| "test/workers/#{m[1]}_test.rb" }
  watch(%r{^lib/(.+)\.rb$}) { |m| "test/unit/lib/#{m[1]}_test.rb" }
  watch(%r{^lib/tasks/(.+)\.rake$}) { |m| "test/unit/lib/tasks/#{m[1]}_test.rb" }
  watch(%r{^test/.+_test\.rb$})
  watch(%r{^test/test_helper\.rb$}) { "test" }
end
