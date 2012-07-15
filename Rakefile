require 'rubygems'
require 'rake'
require 'jeweler'

Jeweler::Tasks.new do |gem|
  gem.name = "sently-sms"
  gem.summary = "Sent.ly SMS gem"
  gem.description ="Allow to send SMSes using the sent.ly service"
  #gem.rubyforce_project ="N/A"
  gem.email = "jerome.lacoste@gmail.com"
  gem.homepage = "http://github.com/lacostej/sently-sms"
  gem.authors = ["Jerome Lacoste"]
  gem.add_development_dependency "shoulda", ">= 0"
  gem.add_development_dependency "mocha", ">= 0"
  gem.add_runtime_dependency "rest-client", ">= 1.6.0"
  # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
end
Jeweler::GemcutterTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "sently-sms #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
