Gem::Specification.new do |spec|
  spec.name          = "lita-catme"
  spec.version       = "0.2.0"
  spec.authors       = ["Emile Filteau"]
  spec.email         = ["emile.filteau@gmail.com"]
  spec.description   = %q(A lita handler that fetch random cat images)
  spec.summary       = %q(A lita handler that fetch random cat images)
  spec.homepage      = "https://github.com/Emile-Filteau/lita-catme"
  spec.license       = "MIT"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", "~> 4.7"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rspec", ">= 3.0.0"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "coveralls"
end
