# -*- encoding: utf-8 -*-
require File.expand_path('../lib/lorem/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["jay_li"]
  gem.email         = ["jay_li@intfocus.com"]
  gem.description   = %q{gem learning}
  gem.summary       = %q{excited}
  gem.homepage      = "https://github.com/jay16"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "lorem"
  gem.require_paths = ["lib"]
  gem.version       = Lorem::VERSION
end
