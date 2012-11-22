# -*- encoding: utf-8 -*-
require File.expand_path('../lib/puppet-parse/version', __FILE__)

if ENV.key?('PUPPET_VERSION')
  puppetversion = "= #{ENV['PUPPET_VERSION']}"
else
  puppetversion = ['>= 2.7']
end

Gem::Specification.new do |gem|
  gem.authors       = ["Johan van den Dorpe"]
  gem.email         = ["johan.vandendorpe@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "puppet-parse"
  gem.require_paths = ["lib"]
  gem.version       = PuppetParse::VERSION

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rake"
  gem.add_runtime_dependency "rdoc"
  gem.add_runtime_dependency "puppet", puppetversion

end
