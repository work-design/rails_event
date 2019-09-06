$:.push File.expand_path('lib', __dir__)
require 'rails_booking/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = 'rails_booking'
  s.version = RailsBooking::VERSION
  s.authors = ['qinmingyuan']
  s.email = ['mingyuan0715@foxmail.com']
  s.homepage = 'https://github.com/work-design/rails_booking'
  s.summary = 'Summary of RailsBooking.'
  s.description = 'Description of RailsBooking.'
  s.license = 'LGPL-3.0'

  s.files = Dir[
    '{app,config,db,lib}/**/*',
    'LICENSE',
    'Rakefile',
    'README.md'
  ]

  s.add_dependency 'rails', '>= 5.0', '<= 6.0'

  s.add_development_dependency 'sqlite3', '~> 1.3'
end
