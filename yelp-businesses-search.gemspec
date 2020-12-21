# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'yelp-businesses-search'
  s.version     = '0.0.1'
  s.date        = '2020-12-21'
  s.summary     = 'Yelp Businesses Search'
  s.description = "Client for Yelp's business search endpoints"
  s.authors     = ['Marcin Chochowski']
  s.email       = ['mchochowski@gmail.com']
  s.homepage    = 'https://github.com/mchochowski/yelp-businesses-search'
  s.license     = 'MIT'
  s.files        = Dir['{lib}/**/*.rb', 'bin/*', 'LICENSE', '*.md']
  s.require_path = 'lib'
  s.required_ruby_version = '>= 2.6'

  s.add_dependency 'rest-client', '~> 2.1'
  s.add_development_dependency 'bundler', '2.2.2'
  s.add_development_dependency 'pry', '~> 0.13'
  s.add_development_dependency 'rspec', '~> 3.10'
  s.add_development_dependency 'rubocop', '~> 1.6'
  s.add_development_dependency 'webmock', '~> 3.11'
end
