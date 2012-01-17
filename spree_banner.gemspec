# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_banner'
  s.version     = '0.70.3'
  s.summary     = 'Extension to manage banner for you Spree Shop'
  s.required_ruby_version = '>= 1.8.7'

  s.author            = 'Damiano Giacomello'
  s.email             = 'damiano.giacomello@diginess.it'
  # s.homepage          = 'http://www.rubyonrails.org'
  # s.rubyforge_project = 'actionmailer'

  #s.files         = `git ls-files`.split("\n")
  s.files        = Dir['CHANGELOG', 'README.md', 'LICENSE', 'lib/**/*', 'app/**/*']
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '>= 0.70.1'
  s.add_dependency 'spree_auth', '>= 0.70.1'
  s.add_dependency 'formtastic'
  s.add_dependency 'paperclip', '>= 2.4.1'
  s.add_development_dependency 'rspec-rails'
end

