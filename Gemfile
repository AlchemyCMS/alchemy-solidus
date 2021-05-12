source "https://rubygems.org"

solidus_branch = ENV.fetch("SOLIDUS_BRANCH", "v2.11")
gem "solidus_core", github: "solidusio/solidus", branch: solidus_branch
gem "solidus_frontend", github: "solidusio/solidus", branch: solidus_branch
gem "solidus_backend", github: "solidusio/solidus", branch: solidus_branch

alchemy_branch = ENV.fetch("ALCHEMY_BRANCH", "main")
gem "alchemy_cms", github: "AlchemyCMS/alchemy_cms", branch: alchemy_branch
gem "alchemy-devise", github: "AlchemyCMS/alchemy-devise", branch: "main"

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
