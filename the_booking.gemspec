$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "the_booking/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "the_booking"
  s.version     = TheBooking::VERSION
  s.authors     = ["qinmingyuan"]
  s.email       = ["mingyuan0715@foxmail.com"]
  s.homepage    = ""
  s.summary     = "Summary of TheBooking."
  s.description = "Description of TheBooking."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails"

  s.add_development_dependency "sqlite3"
end
