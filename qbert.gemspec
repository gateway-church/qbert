require_relative 'lib/qbert/version'

Gem::Specification.new do |spec|
  spec.name          = "qbert"
  spec.version       = Qbert::VERSION
  spec.authors       = ["Tad Preston"]
  spec.email         = ["tad.preston@gatewaystaff.com"]

  spec.summary       = %q{Write a short summary, because RubyGems requires one.}
  spec.description   = %q{Write a longer description or delete this line.}
  spec.homepage      = "https://gatewaypeople.com"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'pry-byebug', '~> 3.9'
  spec.add_dependency "aws-sdk-sqs", "~> 1.36"
end
