# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'goedel/version'

Gem::Specification.new do |spec|
  spec.name          = "goedel"
  spec.version       = Goedel::VERSION
  spec.authors       = ["Steven Li"]
  spec.email         = ["steven@anyperk.com"]

  spec.summary       = %q{ Generate activerecord create statements from activerecord data  }
  spec.description   = %q{ Generate activerecord create statements from activerecord data.}
  spec.homepage      = "http://www.github.com/StevenJL/goedel"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 3.2"

  spec.add_development_dependency "bundler", "~> 1.7.6"
  spec.add_development_dependency "pry", "0.10.3"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "tzinfo", "~> 1.2"
end
