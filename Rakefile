#!/usr/bin/env rake
begin
  require "bundler/setup"
rescue LoadError
  puts "You must `gem install bundler` and `bundle install` to run rake tasks"
end
Bundler::GemHelper.install_tasks

require "rspec/core"
require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec)

task default: [:test_setup, :spec]

require "active_support/core_ext/string"

desc "Setup test app"
task :test_setup do
  solidus_version = ENV.fetch("SOLIDUS_VERSION", "3.2")
  solidus_32_install_options = "--payment-method none --frontend none --no-with-authentication"
  solidus_33_install_options = "--payment-method none --frontend none --authentication none"
  solidus_install_options = solidus_version == "3.2" ? solidus_32_install_options : solidus_33_install_options
  Dir.chdir("spec/dummy") do
    system <<-SETUP.strip_heredoc
      bin/rake db:environment:set db:drop && \
      bin/rake gutentag:install:migrations && \
      bin/rails g gutentag:migration_versions && \
      bin/rails g solidus:install --force --auto-accept --no-seed --no-sample #{solidus_install_options} && \
      bin/rails g solidus_frontend:install --force --auto-accept && \
      bin/rails javascript:install:esbuild && \
      bin/rails g alchemy:solidus:install --auto-accept --force && \
      bin/rake db:test:prepare && \
      bin/rails javascript:build
    SETUP
    exit($?.exitstatus) unless $?.success?
  end
end

require "github_changelog_generator/task"
require "alchemy/solidus/version"
GitHubChangelogGenerator::RakeTask.new(:changelog) do |config|
  config.user = "AlchemyCMS"
  config.project = "alchemy-solidus"
  config.future_release = "v#{Alchemy::Solidus::VERSION}"
end
