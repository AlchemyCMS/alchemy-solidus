#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end
Bundler::GemHelper.install_tasks

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task default: [:test_setup, :spec]

require 'active_support/core_ext/string'

desc 'Setup test app'
task :test_setup do
  Dir.chdir('spec/dummy') do
    system <<-SETUP.strip_heredoc
      export RAILS_ENV=test && \
      bin/rake db:environment:set db:drop && \
      bin/rails g spree:install --force --auto-accept --no-seed --no-sample && \
      bin/rails g alchemy:solidus:install --auto-accept --force
    SETUP
    exit($?.exitstatus) unless $?.success?
  end
end

require 'github_changelog_generator/task'
require 'alchemy/solidus/version'
GitHubChangelogGenerator::RakeTask.new(:changelog) do |config|
  config.user = 'AlchemyCMS'
  config.project = 'alchemy-solidus'
  config.future_release = "v#{Alchemy::Solidus::VERSION}"
end
