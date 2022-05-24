require "awesome_print"
require "pry"

require './lib/potato_debugger/version'
require './lib/potato_debugger/hooks'
require './lib/potato_debugger/hook_helper'

class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

sam = Person.new 'Sam'

hook = PotatoDebugger::Hook.new sam, pry: false, binding: true
sam.name = 'Potato'
ap sam

binding.pry