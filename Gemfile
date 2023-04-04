source "https://rubygems.org"

solidus_version = ENV.fetch("SOLIDUS_VERSION", "3.2")
gem "solidus_core", "~> #{solidus_version}.0"
gem "solidus_frontend", "~> #{solidus_version}.0"
gem "solidus_backend", "~> #{solidus_version}.0"

gem "alchemy_cms", "~> 7.0.0-a"
gem "alchemy-devise", github: "AlchemyCMS/alchemy-devise", branch: "main"

# Specify your gem's dependencies in alchemy-solidus.gemspec
gemspec

gem "sqlite3"
gem "pry-rails"
gem "sprockets", "~> 4.0"
gem "jsbundling-rails", "~> 1.1"
gem "rails", "~> 6.1.0"
gem "listen"
gem "puma"
gem "deface"

group :development, :test do
  # execjs 2.8 removes deprecation warnings but also breaks a number of dependent projects.
  # in our case the culprit is `handlebars-assets`. The changes between 2.7.0 and 2.8.0 are
  # minimal, but breaking.
  gem "execjs", "= 2.7.0"
end
