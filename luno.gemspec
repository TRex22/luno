lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "luno/version"

Gem::Specification.new do |spec|
  spec.name          = "luno"
  spec.version       = Luno::VERSION
  spec.authors       = ["trex22"]
  spec.email         = ["contact@jasonchalom.com"]

  spec.summary       = "A client for using the Luno API in Ruby."
  spec.description   = "A client for using the Luno API in Ruby. Built form their api documentation. https://www.luno.com/en/developers/api. This is an unofficial project."
  spec.homepage      = "https://github.com/TRex22/luno"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "~> 0.18"
  spec.add_dependency "active_attr", "~> 0.15"
  spec.add_dependency "nokogiri", ">= 1.11.2", "< 1.13.0"

  # Development dependancies
  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-focus", "~> 1.1.2"
  spec.add_development_dependency "minitest-reporters", "~> 1.4.2"
  spec.add_development_dependency "timecop", "~> 0.9.1"
  spec.add_development_dependency "mocha", "~> 1.11.2"
  spec.add_development_dependency "pry", "~> 0.13"
  spec.add_development_dependency "webmock", "~> 3.8.3"
end
