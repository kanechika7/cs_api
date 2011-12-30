# coding: UTF-8
lib = File.expand_path('../lib', __FILE__)
$:.unshift lib unless $:.include?(lib)

require "cs_api/version"

Gem::Specification.new do |s|
  s.name        = "cs_api"
  s.version     = CsApi::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nozomu Kanechika"]
  s.email       = ["kanechika7@gmail.com"]
  s.homepage    = 'http://github.com/kanechika7/cs_api'
  s.summary     = "Automatically Generated Tool For Cookie Session API"
  s.description = "cs_api is ......."

  s.rubyforge_project = 'cs_api'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.extra_rdoc_files = ['README.md']
  s.require_paths = ['lib']

  #s.licenses = ['MIT']

  s.required_rubygems_version = ">= 1.3.6"
  s.add_dependency("rails",[">= 3.0.0"])
  s.add_dependency 'mongoid', ['>= 2']
  s.add_dependency 'rspec', ['2.8.0.rc1']
  s.add_dependency 'rspec-rails', ['>= 0']
  s.add_dependency 'mocha', ['>= 0']
  s.add_dependency 'rr', ['>= 0']


  #s.add_dependency("strut",[":git => 'https://github.com/kuruma-gs/strut.git'"])
  #s.files        = Dir.glob("lib/**/*") + %W(README.md Rakefile)
  #s.require_paths = ['lib']
end

