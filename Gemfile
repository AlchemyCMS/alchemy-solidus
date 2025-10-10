source "https://rubygems.org"

solidus_branch = ENV.fetch("SOLIDUS_BRANCH", "v4.4")
gem "solidus_core", github: "solidusio/solidus", branch: solidus_branch
gem "solidus_backend", github: "solidusio/solidus", branch: solidus_branch
gem "solidus_frontend", github: "solidusio/solidus_frontend", branch: "main"

alchemy_branch = ENV.fetch("ALCHEMY_BRANCH", "8.0-stable")
gem "alchemy_cms", github: "AlchemyCMS/alchemy_cms", branch: alchemy_branch
gem "alchemy-devise", github: "AlchemyCMS/alchemy-devise", branch: alchemy_branch

# Specify your gem's dependencies in alchemy-solidus.gemspec
gemspec

gem "sqlite3", "~> 1.4"
gem "pry-rails"
gem "sprockets", "~> 4.0"
gem "jsbundling-rails", "~> 1.1"
gem "rails", ">= 6.1.0"
gem "listen"
gem "deface"

if ["v4.1", "v4.2"].include?(solidus_branch)
  gem "concurrent-ruby", "< 1.3.5"
end

group :development, :test do
  # execjs 2.8 removes deprecation warnings but also breaks a number of dependent projects.
  # in our case the culprit is `handlebars-assets`. The changes between 2.7.0 and 2.8.0 are
  # minimal, but breaking.
  gem "execjs", "= 2.7.0"
end

group :lint do
  gem "rubocop", require: false
  gem "standard", "~> 1.25", require: false
end
