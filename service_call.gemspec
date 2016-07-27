# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'service_call/version'

Gem::Specification.new do |spec|
  spec.name          = "service_call"
  spec.version       = ServiceCall::VERSION
  spec.authors       = ["James Mason"]
  spec.email         = ["jmason@kloveair1.com"]

  spec.summary       = %q{A little niceness for callable service objects.}
  spec.description   = %q{A module for defining simple service objects.}
  spec.homepage      = "https://github.com/emfeng/service_call"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
