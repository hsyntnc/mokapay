
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "moka/version"

Gem::Specification.new do |spec|
  spec.name          = "mokapay"
  spec.version       = Moka::VERSION
  spec.authors       = ["H\xC3\xBCseyin TUN\xC3\x87"]
  spec.email         = ["huseyin.tunc@bulutfon.com"]

  spec.summary       = %q{Ruby gem for Moka payment system.}
  #spec.description   = %q{}
  spec.homepage      = "http://github.com/hsyntnc/mokapay"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rest-client", "~> 2.1.0"
end
