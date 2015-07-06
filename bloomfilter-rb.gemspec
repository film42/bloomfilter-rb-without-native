# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "bloomfilter/version"

Gem::Specification.new do |s|
  s.name        = "bloomfilter-rb-without-native"
  s.version     = BloomFilter::VERSION
  s.authors     = ["Garrett Thornburg"]
  s.email       = ["film42@gmail.com"]
  s.homepage    = "https://github.com/film42/bloomfilter-rb-without-native/"
  s.summary     = "Counting Bloom Filter implemented in Ruby (fork without native code)"
  s.description = s.summary

  s.add_dependency "redis"
  s.add_development_dependency "rspec", ">= 3"
  s.add_development_dependency "rake"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
