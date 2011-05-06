# encoding: utf-8

require 'rubygems'
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "simplejob"
  gem.homepage = "http://github.com/kenpratt/simplejob"
  gem.license = "MIT"
  gem.summary = "Painless job queueing."
  gem.description = "A simple AMQP-backed job queuing system."
  gem.email = "ken@kenpratt.net"
  gem.authors = ["Ken Pratt"]
  gem.add_dependency "activesupport", ">= 3.0.1"
  gem.add_dependency "json", ">= 1.5.1"
  gem.add_dependency "amqp", "0.7.1"
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "gems/*"'
end

task :default => :test
