# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'faraday_error/version'

Gem::Specification.new do |spec|
  spec.name          = "faraday_error"
  spec.version       = FaradayError::VERSION
  spec.authors       = ["Jacob Elder"]
  spec.email         = ["jacob.elder@gmail.com"]

  spec.summary       = %q{A Faraday middleware for adding request parameters to your exception tracker.}
  spec.description   = File.read("README.md")
  spec.homepage      = "https://github.com/jelder/faraday_error/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 0.9.2"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'sinatra', '~> 1.4', '>= 1.4.7'
  spec.add_development_dependency 'honeybadger', '~> 2.4', '>= 2.4.1'
  spec.add_development_dependency 'newrelic_rpm', '~> 3.14', '>= 3.14.0'
end
