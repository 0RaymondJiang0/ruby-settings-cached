# coding: utf-8
Gem::Specification.new do |s|
  s.name = 'ruby-settings-cached'
  s.version = '0.1.1'
  s.required_ruby_version = '>= 2.0'

  s.required_rubygems_version = Gem::Requirement.new('>= 0') if s.respond_to? :required_rubygems_version=
  s.authors = ['Squeegy', 'Georg Ledermann', '100hz', 'Jason Lee', 'Raymond Jiang']
  s.email = 'huacnlee@gmail.com'
  s.files = Dir.glob('lib/**/*') + %w(README.md)
  s.homepage = 'https://github.com/RobotJiang/ruby-settings-cached'
  s.require_paths = ['lib']
  s.summary = 'This is improved from rails-settings, added caching. Settings is a plugin that makes managing a table of global key, value pairs easy. Think of it like a global Hash stored in you database, that uses simple ActiveRecord like methods for manipulation.  Keep track of any global setting that you dont want to hard code into your rails app.  You can store any kind of object.  Strings, numbers, arrays, or any object. Ported to Rails 3!'

  s.add_dependency 'activerecord', '>= 4.2.0'
  s.add_dependency 'activesupport', '>= 4.2.0'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '>= 3.3.0'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'sqlite3', '>= 1.3.10'
end
