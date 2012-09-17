# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mixi/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Kazuhiro Hayashi"]
  gem.email         = ["k.hayashi.info+github@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ruby4mixi"
  gem.require_paths = ["lib"]
  gem.version       = Mixi::VERSION
end
