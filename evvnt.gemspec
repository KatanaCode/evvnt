lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "evvnt/version"

Gem::Specification.new do |spec|
  spec.name          = "evvnt"
  spec.version       = Evvnt::VERSION
  spec.authors       = ["Bodacious"]
  spec.email         = ["bodacious@katanacode.com"]

  spec.summary       = "A wrapper for the EVVNT API"
  spec.description   = "Provides a wrapper and helper classes for the EVVNT rest API"
  spec.homepage      = "https://github.com/katanacode.com/evvnt"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(spec)/})
  end
  spec.require_paths = ["lib"]
  spec.add_dependency "activesupport", ">= 3.0"
  spec.add_dependency "httparty", ">= 0.16.0"
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "rubocop"
end
