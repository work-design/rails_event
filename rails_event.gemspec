$:.push File.expand_path('lib', __dir__)
require 'rails_event/version'

Gem::Specification.new do |s|
  s.name = 'rails_event'
  s.version = RailsEvent::VERSION
  s.authors = ['qinmingyuan']
  s.email = ['mingyuan0715@foxmail.com']
  s.homepage = 'https://github.com/work-design/rails_event'
  s.summary = '时间、地点、参与者管理系统'
  s.description = 'Description of RailsEvent.'
  s.license = 'MIT'

  s.files = Dir[
    '{app,config,db,lib}/**/*',
    'LICENSE',
    'Rakefile',
    'README.md'
  ]

  s.add_dependency 'rails_com', '~> 1.2'
  s.add_development_dependency 'sqlite3', '~> 1.3'
end
