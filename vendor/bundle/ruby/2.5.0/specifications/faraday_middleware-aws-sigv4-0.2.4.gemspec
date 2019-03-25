# -*- encoding: utf-8 -*-
# stub: faraday_middleware-aws-sigv4 0.2.4 ruby lib

Gem::Specification.new do |s|
  s.name = "faraday_middleware-aws-sigv4".freeze
  s.version = "0.2.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Genki Sugawara".freeze]
  s.bindir = "exe".freeze
  s.date = "2018-01-30"
  s.description = "Faraday middleware for AWS Signature Version 4 using aws-sigv4.".freeze
  s.email = ["sugawara@cookpad.com".freeze]
  s.homepage = "https://github.com/winebarrel/faraday_middleware-aws-sigv4".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.7.6".freeze
  s.summary = "Faraday middleware for AWS Signature Version 4 using aws-sigv4.".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<faraday>.freeze, [">= 0.9"])
      s.add_runtime_dependency(%q<aws-sigv4>.freeze, ["~> 1.0"])
      s.add_development_dependency(%q<faraday_middleware>.freeze, [">= 0"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<timecop>.freeze, [">= 0"])
      s.add_development_dependency(%q<coveralls>.freeze, [">= 0"])
      s.add_development_dependency(%q<aws-sdk-core>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<appraisal>.freeze, [">= 2.2"])
    else
      s.add_dependency(%q<faraday>.freeze, [">= 0.9"])
      s.add_dependency(%q<aws-sigv4>.freeze, ["~> 1.0"])
      s.add_dependency(%q<faraday_middleware>.freeze, [">= 0"])
      s.add_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_dependency(%q<timecop>.freeze, [">= 0"])
      s.add_dependency(%q<coveralls>.freeze, [">= 0"])
      s.add_dependency(%q<aws-sdk-core>.freeze, ["~> 3.0"])
      s.add_dependency(%q<appraisal>.freeze, [">= 2.2"])
    end
  else
    s.add_dependency(%q<faraday>.freeze, [">= 0.9"])
    s.add_dependency(%q<aws-sigv4>.freeze, ["~> 1.0"])
    s.add_dependency(%q<faraday_middleware>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<timecop>.freeze, [">= 0"])
    s.add_dependency(%q<coveralls>.freeze, [">= 0"])
    s.add_dependency(%q<aws-sdk-core>.freeze, ["~> 3.0"])
    s.add_dependency(%q<appraisal>.freeze, [">= 2.2"])
  end
end
