require_relative './lib/version'

Gem::Specification.new do |s|
  s.name         = "longforms"
  s.version      = Longforms::VERSION
  s.date         = "2016-05-07"
  s.summary      = "Editor's picks from Longreads.com"
  s.description  = "Provides details on the longform articles from Longreads.com."
  s.authors      = ["Katherine Thai"]
  s.email        = 'kthai1618@gmail.com'
  s.files        = ['lib/article.rb','lib/cli.rb','lib/scraper.rb','config/environment.rb']
  s.homepage     = "https://rubygems.org/gems/longforms"
  s.license      = "MIT"
  s.executables << "longforms"

  s.add_development_dependency "bundler", "~> 1.10"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec", ">= 0"
  s.add_development_dependency "nokogiri", ">= 0"
  s.add_development_dependency "pry", ">= 0"
  s.add_development_dependency "colorize", '~> 0.7.7'
end