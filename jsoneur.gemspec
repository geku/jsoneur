# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jsoneur/version'

Gem::Specification.new do |spec|
  spec.name          = "jsoneur"
  spec.version       = Jsoneur::VERSION
  spec.authors       = ["Georg Kunz"]
  spec.email         = ["kwd@gmx.ch"]
  spec.description   = 'General purpose JSON API client'
  spec.summary       = 'Very simple and generic JSON API client based on Faraday and providing a service registry for configuration and usage of multiple services.'
  spec.homepage      = "http://georgkunz.com"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 1.9"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'hashie'
  spec.add_runtime_dependency 'multi_json'
  spec.add_runtime_dependency 'faraday'
  spec.add_runtime_dependency 'faraday_middleware'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.14'
end
