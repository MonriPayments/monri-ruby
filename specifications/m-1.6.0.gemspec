# -*- encoding: utf-8 -*-
# stub: m 1.6.0 ruby lib

Gem::Specification.new do |s|
  s.name = "m".freeze
  s.version = "1.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nick Quaranto".freeze]
  s.date = "2021-09-09"
  s.description = "Run test/unit tests by line number. Metal!".freeze
  s.email = ["nick@quaran.to".freeze]
  s.executables = ["m".freeze]
  s.files = ["bin/m".freeze]
  s.homepage = "https://github.com/qrush/m".freeze
  s.required_ruby_version = Gem::Requirement.new(">= 1.9".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Run test/unit tests by line number. Metal!".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<method_source>.freeze, [">= 0.6.7"])
      s.add_runtime_dependency(%q<rake>.freeze, [">= 0.9.2.2"])
      s.add_development_dependency(%q<activesupport>.freeze, [">= 0"])
      s.add_development_dependency(%q<rdiscount>.freeze, [">= 0"])
      s.add_development_dependency(%q<rocco>.freeze, [">= 0"])
      s.add_development_dependency(%q<appraisal>.freeze, [">= 0"])
    else
      s.add_dependency(%q<method_source>.freeze, [">= 0.6.7"])
      s.add_dependency(%q<rake>.freeze, [">= 0.9.2.2"])
      s.add_dependency(%q<activesupport>.freeze, [">= 0"])
      s.add_dependency(%q<rdiscount>.freeze, [">= 0"])
      s.add_dependency(%q<rocco>.freeze, [">= 0"])
      s.add_dependency(%q<appraisal>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<method_source>.freeze, [">= 0.6.7"])
    s.add_dependency(%q<rake>.freeze, [">= 0.9.2.2"])
    s.add_dependency(%q<activesupport>.freeze, [">= 0"])
    s.add_dependency(%q<rdiscount>.freeze, [">= 0"])
    s.add_dependency(%q<rocco>.freeze, [">= 0"])
    s.add_dependency(%q<appraisal>.freeze, [">= 0"])
  end
end
