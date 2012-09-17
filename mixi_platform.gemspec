# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mixi_platform/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Kazuhiro Hayashi"]
  gem.email         = ["k.hayashi.info+github@gmail.com"]
  gem.description   = %q{MixiのGraph APIをRubyで取り扱うためのライブラリです。}
  gem.summary       = %q{作成中。}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "mixi_platform"
  gem.require_paths = ["lib"]
  gem.version       = MixiPlatform::VERSION
end
