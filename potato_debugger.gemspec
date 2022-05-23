# frozen_string_literal: true

require File.expand_path('../lib/version', __FILE__)

Gem::Specification.new do |s|
  s.name = "Potato Debugger"
  s.version = PotatoDebugger::VERSION

  s.required_ruby_version = '>= 2.7'

  s.authors = [
    "Samuel O'Donnell"
  ]

  s.email = [
    "samboy29@gmail.com"
  ]

  s.summary = "A super early prototype of a debugging tool for Ruby."

  s.description = <<DESC
An extremely early build for a Ruby Debugging tool, designed to be able to hook into various
classes and track changes.  Not intended to be used by others at this stage.
DESC

  s.homepage = ""
  s.licenses = ["MIT"]

  s.executables = ["init"]
  s.require_paths = ["lib"]
  s.files = ''


end