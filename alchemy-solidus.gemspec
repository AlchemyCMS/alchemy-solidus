# -*- encoding: utf-8 -*-
require File.expand_path('../lib/alchemy/solidus/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Thomas von Deyen"]
  gem.email         = ["tvd@magiclabs.de"]
  gem.description   = %q{A Alchemy CMS and Solidus connector}
  gem.summary       = %q{The World's Most Flexible E-Commerce Platform meets The World's Most Flexible Content Management System!}
  gem.homepage      = "https://github.com/AlchemyCMS/alchemy-solidus"
  gem.license       = 'BSD New'
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "alchemy-solidus"
  gem.require_paths = ["lib"]
  gem.version       = Alchemy::Solidus::VERSION

  gem.add_dependency('alchemy_cms', ['>= 4.0.0.beta', '< 5.0'])
  gem.add_dependency('solidus_core', ['~> 2.0'])
  gem.add_dependency('solidus_backend', ['~> 2.0'])
  gem.add_dependency('deface', ['~> 1.0'])

  gem.add_development_dependency('rspec-rails', ['~> 3.7'])
  gem.add_development_dependency('capybara', ['~> 2.15'])
  gem.add_development_dependency('capybara-screenshot', ['~> 1.0'])
  gem.add_development_dependency('factory_bot', ['~> 4.8'])
  gem.add_development_dependency('ffaker', ['~> 2.7'])
end
