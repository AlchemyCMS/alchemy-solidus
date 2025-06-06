require File.expand_path("../lib/alchemy/solidus/version", __FILE__)

Gem::Specification.new do |gem|
  gem.authors = ["Thomas von Deyen"]
  gem.email = ["thomas@vondeyen.com"]
  gem.description = "A AlchemyCMS and Solidus integration"
  gem.summary =
    "The World's Most Flexible E-Commerce Platform meets The World's Most Flexible Content Management System!"
  gem.homepage = "https://github.com/AlchemyCMS/alchemy-solidus"
  gem.license = "BSD-3-Clause"
  gem.files =
    Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]
  gem.name = "alchemy-solidus"
  gem.require_paths = ["lib"]
  gem.version = Alchemy::Solidus::VERSION

  gem.add_dependency("alchemy_cms", [">= 7.2.0", "< 8"])
  gem.add_dependency("solidus_core", [">= 4.0.0", "< 5"])
  gem.add_dependency("solidus_backend", [">= 4.0.0", "< 5"])
  gem.add_dependency("solidus_support", [">= 0.14.0", "< 1"])
  gem.add_dependency("deface", ["~> 1.0"])

  gem.add_development_dependency("rspec-rails", ["~> 6.0"])
  gem.add_development_dependency("shoulda-matchers", ["~> 4.0"])
  gem.add_development_dependency("capybara", ["~> 3.0"])
  gem.add_development_dependency("capybara-screenshot", ["~> 1.0"])
  gem.add_development_dependency("factory_bot", ["~> 6.4"])
  gem.add_development_dependency("ffaker", ["~> 2.7"])
  gem.add_development_dependency("github_changelog_generator", "~> 1.16")
  gem.add_development_dependency("selenium-webdriver", ["~> 4.11"])
  gem.add_development_dependency("puma", ["~> 6.0"])
end
