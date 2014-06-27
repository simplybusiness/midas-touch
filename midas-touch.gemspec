lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'midas-touch/version'

Gem::Specification.new do |spec|
  spec.name          = "midas-touch"
  spec.version       = MidasTouch::VERSION
  spec.authors       = ["Darren Coxall", "Martin Laine"]
  spec.email         = ["darren@simplybusiness.co.uk", "martin.laine@simplybusiness.co.uk"]
  spec.summary       = %q{Turn all your inputs to Gold.}
  spec.description   = %q{Clean and validate your inputs from forms or other areas of your application.}
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "minitest", "~> 5.3.5"
  spec.add_development_dependency "sinatra"
end
