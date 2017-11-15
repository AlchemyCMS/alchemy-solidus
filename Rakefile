#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end
begin
  require 'rdoc/task'
rescue LoadError
  require 'rdoc/rdoc'
  require 'rake/rdoctask'
  RDoc::Task = Rake::RDocTask
end

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'AlchemySolidus'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Bundler::GemHelper.install_tasks

require 'active_support/core_ext/string'

desc 'Setup test app'
task :test_setup do
  Dir.chdir('spec/dummy') do
    system <<-SETUP.strip_heredoc
      export RAILS_ENV=test && \
      bin/rake db:environment:set db:drop && \
      bin/rails g spree:install --force --quiet --auto-accept --no-seed --no-sample && \
      bin/rails g alchemy:solidus:install --auto-accept
    SETUP
    exit($?.exitstatus) unless $?.success?
  end
end
