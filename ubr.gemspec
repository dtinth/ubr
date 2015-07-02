# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ubr/version'

Gem::Specification.new do |spec|
  spec.name          = "ubr"
  spec.version       = Ubr::VERSION
  spec.authors       = ["Thai Pangsakulyanont"]
  spec.email         = ["dtinth@spacet.me"]
  spec.summary       = %q{Request an Uber from the CLI}
  spec.description   = %q{ubr is a command line script that utilizes the Uber API to request a ride for the user.}
  spec.homepage      = "https://github.com/dtinth/ubr"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rest-client"
  spec.add_runtime_dependency "activesupport"
  spec.add_runtime_dependency "launchy"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
