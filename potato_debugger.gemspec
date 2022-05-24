# frozen_string_literal: true

$:.push File.expand_path("../lib", __FILE__)

require_relative 'lib/potato_debugger/version'

Gem::Specification.new do |s|
  s.name = "potato_debugger"
  s.version = PotatoDebugger::VERSION

  s.required_ruby_version = '>= 2.7'

  s.authors = [
    "Samuel O'Donnell"
  ]

  s.email = [
    ""
  ]

  s.summary = "A super early prototype of a debugging tool for Ruby. Not worth using yet."

  s.description = <<DESC
An extremely early build for a Ruby Debugging tool, designed to be able to hook into various
classes and track changes.  Not intended to be used by others at this stage.
DESC

  s.homepage = "https://github.com/PotatoBaron89/PotatoBaronDebugger"
  s.licenses = ["MIT"]

  s.executables = ["debugger"]
  s.require_paths = ["lib"]
  s.files = `git ls-files bin lib *.md LICENSE`.split("\n")

  s.add_dependency 'pry', '~> 0.14.1'
  s.add_dependency 'awesome_print', '~> 1.9', '>= 1.9.2'

  s.metadata['changelog_uri'] = 'https://github.com/PotatoBaron89/PotatoBaronDebugger/blob/masterCHANGELOG.md'
end