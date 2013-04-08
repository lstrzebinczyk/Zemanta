# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zemanta/version'

Gem::Specification.new do |gem|
  gem.name          = "zemanta"
  gem.version       = Zemanta::VERSION
  gem.authors       = ["Łukasz Strzebińczyk"]
  gem.email         = ["l.strzebinczyk@gorailsgo.com"]
  gem.description   = "This is a ruby client for Zemanta api."
  gem.summary       = "This is a ruby client for Zemanta api."
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "typhoeus"
  gem.add_dependency "activesupport"

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "webmock"
end
