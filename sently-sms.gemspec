# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sently-sms}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jerome Lacoste"]
  s.date = %q{2012-07-15}
  s.default_executable = %q{sently}
  s.description = %q{Allow to send SMSes using the sent.ly service}
  s.email = %q{jerome.lacoste@gmail.com}
  s.executables = ["sently"]
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION.yml",
    "bin/sently",
    "lib/sently-sms.rb",
    "lib/sently/configuration.rb",
    "lib/sently/sender.rb",
    "lib/sently/sms.rb",
    "test/helper.rb",
    "test/sms_test.rb"
  ]
  s.homepage = %q{http://github.com/lacostej/sently-sms}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Sent.ly SMS gem}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_runtime_dependency(%q<rest-client>, [">= 1.6.0"])
    else
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<rest-client>, [">= 1.6.0"])
    end
  else
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<rest-client>, [">= 1.6.0"])
  end
end

