require 'bundler/gem_tasks'
require 'rake'
require 'rspec'
require 'rspec/core/rake_task'

Bundler::GemHelper.install_tasks
RSpec::Core::RakeTask.new(:spec)
Rake::Task[:spec].prerequisites << :clean
Rake::Task[:spec].prerequisites << :compile
