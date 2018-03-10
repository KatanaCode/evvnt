lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "evvnt/version"

Gem::Specification.new do |spec|
  spec.name          = "evvnt"
  spec.version       = Evvnt::VERSION
  spec.authors       = ["Bodacious"]
  spec.email         = ["bodacious@katanacode.com"]

  spec.summary       = "A wrapper for the EVVNT API"
  spec.description   = "Unnoficial evvnt API gem provides a wrapper and helper classes "\
                         "for the EVVNT rest API"
  spec.homepage      = "https://github.com/katanacode/evvnt"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(spec)/})
  end
  spec.require_paths = ["lib"]
  spec.add_dependency "activesupport", ">= 3.0"
  spec.add_dependency "httparty", ">= 0.16.0"
  spec.add_dependency "oj"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 3.7.0", "< 4.0"
  spec.add_development_dependency "rubocop", ">= 0.53.0"
  spec.add_development_dependency "webmock", ">= 3.3.0"
  spec.add_development_dependency "dotenv", ">= 2.2.1"
  spec.add_development_dependency "byebug", ">= 10.0.0"
  spec.add_development_dependency "rspec_junit_formatter", ">= 0.3.0"
  spec.add_development_dependency "rspec-collection_matchers", ">= 1.1.3"
end
