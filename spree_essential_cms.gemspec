# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "spree_essential_cms/version"

Gem::Specification.new do |s|
  s.name        = "spree_essential_cms"
  s.version     = SpreeEssentialCms::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Spencer Steffen"]
  s.email       = ["spencer@citrusme.com"]
  s.homepage    = "http://github.com/citrus/spree_essential_cms"
  s.summary     = %q{SpreeEssentialCms is a full featured content management system for Spree Commerce.}
  s.description = %q{SpreeEssentialCms is a full featured content management system for Spree Commerce. It's designed to be used with the spree_essentials base.}

  s.files        = Dir['CHANGELOG', 'README.md', 'LICENSE', 'config/**/*', 'lib/**/*', 'app/**/*', 'db/**/*', 'public/**/*', 'Rakefile']
  s.test_files   = Dir['test']
  
  s.require_paths = ['lib']

  # Spree Essentials
  s.add_dependency('spree_essentials',               '>= 0.1.4')
  
  # Development
	s.add_development_dependency('spree_sample',       '>= 0.30.0')
	s.add_development_dependency('dummier',            '>= 0.2.0')	
	s.add_development_dependency('shoulda',            '>= 2.11.3')
	s.add_development_dependency('factory_girl',       '>= 2.0.0.beta4')
	s.add_development_dependency('capybara',           '>= 1.0.0')
	s.add_development_dependency('selenium-webdriver', '>= 0.1.3')
  s.add_development_dependency('sqlite3',            '>= 1.3.3')
  s.add_development_dependency('spork',              '>= 0.9.0.rc9')
  s.add_development_dependency('spork-testunit',     '>= 0.0.5')
  
end
