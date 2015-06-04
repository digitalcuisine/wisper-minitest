# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wisper/minitest/version'

Gem::Specification.new do |spec|
  spec.name          = 'wisper-minitest'
  spec.version       = Wisper::MiniTest::VERSION
  spec.authors       = ['Olivier Lance @ Digital Cuisine']
  spec.email         = ["olivier@digitalcuisine.fr"]
  spec.summary       = 'MiniTest assertions/expectations and stubbing for Wisper'
  spec.description   = 'MiniTest assertions/expectations and stubbing for Wisper'
  spec.homepage      = 'https://github.com/digitalcuisine/wisper-minitest'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'wisper'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
end
