source "https://rubygems.org"

solidus_branch = ENV.fetch("SOLIDUS_BRANCH", "v4.4")
gem "solidus_core", github: "solidusio/solidus", branch: solidus_branch
gem "solidus_backend", github: "solidusio/solidus", branch: solidus_branch
gem "solidus_frontend", github: "solidusio/solidus_frontend", branch: "main"

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
