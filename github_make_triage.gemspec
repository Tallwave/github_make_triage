$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + '/lib')

require 'make_triage'

Gem::Specification.new do |s|
  s.name                  = 'github_make_triage'
  s.version               = MakeTriage::VERSION
  s.required_ruby_version = '>= 2.0'
  s.summary               = 'Create a Triage Workflow in a GitHub Project'
  s.description           = <<-HERE
    Create a Triage Workflow in a GitHub Project
  HERE
  s.license               = 'MIT'
  s.author                = 'Scott Williams'
  s.email                 = 'scott@swilliams.me'
  s.homepage              = 'https://github.com/Tallwave/github_make_triage'
  s.files                 = Dir['{bin,lib}/**/*'] + ['github_make_triage.gemspec']
  s.executables           = ['make-triage-project']
  s.extra_rdoc_files      = ['LICENSE', 'README.md']
  s.require_paths         = ['lib']
end
