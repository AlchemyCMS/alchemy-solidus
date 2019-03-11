source 'https://rubygems.org'

solidus_branch = ENV.fetch('SOLIDUS_BRANCH', 'master')
gem "solidus_core", github: "solidusio/solidus", branch: solidus_branch
gem "solidus_backend", github: "solidusio/solidus", branch: solidus_branch

# Specify your gem's dependencies in alchemy-solidus.gemspec
gemspec

gem 'sqlite3', '~> 1.3.6' # Fix for sqlite v1.4 broken with latest Rails
gem 'pry-rails'

case solidus_branch
when 'master'
  gem 'alchemy_cms', github: 'AlchemyCMS/alchemy_cms'
  gem 'alchemy-devise', github: 'AlchemyCMS/alchemy-devise'
when 'v2.5', 'v2.6'
  gem 'alchemy_cms', '~> 4.0.4'
  gem 'alchemy-devise'
when 'v2.4'
  gem 'factory_bot', '4.8.2'
  gem 'alchemy-devise'
else
  gem 'alchemy-devise'
end
