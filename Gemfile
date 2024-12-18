source "https://rubygems.org"

solidus_version = ENV.fetch("SOLIDUS_VERSION", "4.4")
gem "solidus_core", "~> #{solidus_version}.0"
gem "solidus_backend", "~> #{solidus_version}.0"
if Gem::Version.new(solidus_version) >= Gem::Version.new("4.0")
  gem "solidus_frontend", github: "solidusio/solidus_frontend", branch: "main"
else
  gem "solidus_frontend", "~> #{solidus_version}.0"
end

alchemy_version = ENV.fetch("ALCHEMY_VERSION", "main")
if alchemy_version == "main"
  gem "alchemy_cms", github: "AlchemyCMS/alchemy_cms", branch: "main"
else
  gem "alchemy_cms", "~> #{alchemy_version}"
end

gem "alchemy-devise", github: "AlchemyCMS/alchemy-devise", branch: "main"

# Specify your gem's dependencies in alchemy-solidus.gemspec
gemspec

gem "sqlite3", "~> 1.4"
gem "pry-rails"
gem "sprockets", "~> 4.0"
gem "jsbundling-rails", "~> 1.1"
gem "rails", ">= 6.1.0"
gem "listen"
gem "puma"
gem "deface"

group :development, :test do
  # execjs 2.8 removes deprecation warnings but also breaks a number of dependent projects.
  # in our case the culprit is `handlebars-assets`. The changes between 2.7.0 and 2.8.0 are
  # minimal, but breaking.
  gem "execjs", "= 2.7.0"
end
