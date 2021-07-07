# -*- encoding: utf-8 -*-
require File.expand_path('../lib/alchemy/solidus/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Thomas von Deyen"]
  gem.email         = ["thomas@vondeyen.com"]
  gem.description   = %q{A AlchemyCMS and Solidus integration}
  gem.summary       = %q{The World's Most Flexible E-Commerce Platform meets The World's Most Flexible Content Management System!}
  gem.homepage      = "https://github.com/AlchemyCMS/alchemy-solidus"
  gem.license       = 'BSD New'
  gem.files         = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]
  gem.name          = "alchemy-solidus"
  gem.require_paths = ["lib"]
  gem.version       = Alchemy::Solidus::VERSION

  gem.add_dependency('alchemy_cms', ['>= 5.0.0', '< 6.1'])
  gem.add_dependency('solidus_core', ['>= 2.10.0', '< 4.0'])
  gem.add_dependency('solidus_backend', ['>= 2.10.0', '< 4.0'])
  gem.add_dependency('solidus_support', ['>= 0.1.1'])
  gem.add_dependency('deface', ['~> 1.0'])

  gem.add_development_dependency('rspec-rails', ['~> 3.7'])
  gem.add_development_dependency('shoulda-matchers', ['~> 4.0'])
  gem.add_development_dependency('capybara', ['~> 2.15'])
  gem.add_development_dependency('capybara-screenshot', ['~> 1.0'])
  gem.add_development_dependency('factory_bot', ['~> 4.8'])
  gem.add_development_dependency('ffaker', ['~> 2.7'])
  gem.add_development_dependency('github_changelog_generator')
end
