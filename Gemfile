source "https://rubygems.org"

solidus_version = ENV.fetch("SOLIDUS_VERSION", "3.2")
gem "solidus_core", "~> #{solidus_version}.0"
gem "solidus_frontend", "~> #{solidus_version}.0"
gem "solidus_backend", "~> #{solidus_version}.0"

alchemy_version = ENV.fetch("ALCHEMY_VERSION", "6.1")
gem "alchemy_cms", "~> #{alchemy_version}.0"
gem "alchemy-devise", "~> #{alchemy_version}.0"

# Specify your gem's dependencies in alchemy-solidus.gemspec
gemspec

gem "sqlite3"
gem "pry-rails"
gem "sprockets", "< 4"

group :development, :test do
  # execjs 2.8 removes deprecation warnings but also breaks a number of dependent projects.
  # in our case the culprit is `handlebars-assets`. The changes between 2.7.0 and 2.8.0 are
  # minimal, but breaking.
  gem "execjs", "= 2.7.0"
end
