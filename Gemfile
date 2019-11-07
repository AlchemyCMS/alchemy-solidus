source 'https://rubygems.org'

solidus_branch = ENV.fetch('SOLIDUS_BRANCH', 'master')
gem "solidus_core", github: "solidusio/solidus", branch: solidus_branch
gem "solidus_backend", github: "solidusio/solidus", branch: solidus_branch

alchemy_branch = ENV.fetch('ALCHEMY_BRANCH', 'master')
gem "alchemy_cms", github: "AlchemyCMS/alchemy_cms", branch: alchemy_branch
gem 'alchemy-devise', github: "AlchemyCMS/alchemy-devise", branch: alchemy_branch

# Specify your gem's dependencies in alchemy-solidus.gemspec
gemspec

gem 'sqlite3', '~> 1.3.6' # Fix for sqlite v1.4 broken with latest Rails
gem 'pry-rails'
gem 'sprockets', '< 4'
