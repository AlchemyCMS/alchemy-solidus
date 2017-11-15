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
      bin/rake db:drop db:create && \
      bin/rails g spree:install --force --quiet --auto-accept --no-seed --no-sample && \
      bin/rails g alchemy:solidus:install --auto-accept
    SETUP
  end
end
