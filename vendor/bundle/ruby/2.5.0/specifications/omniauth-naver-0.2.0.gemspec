# -*- encoding: utf-8 -*-
# stub: omniauth-naver 0.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "omniauth-naver".freeze
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Surim Kim".freeze]
  s.bindir = "exe".freeze
  s.date = "2018-05-17"
  s.description = "OmniAuth strategy for Naver(https://developers.naver.com)".freeze
  s.email = ["kimsuelim@gmail.com".freeze]
  s.homepage = "http://github.com/kimsuelim/omniauth-naver".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.7.6".freeze
  s.summary = "OmniAuth strategy for Naver".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<omniauth-oauth2>.freeze, ["~> 1.2"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.11"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<minitest>.freeze, ["~> 5.0"])
    else
      s.add_dependency(%q<omniauth-oauth2>.freeze, ["~> 1.2"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.11"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<minitest>.freeze, ["~> 5.0"])
    end
  else
    s.add_dependency(%q<omniauth-oauth2>.freeze, ["~> 1.2"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.11"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.0"])
  end
end
