require "awesome_print"
require_relative './lib/potato_debugger/hooks.rb'
require_relative './lib/potato_debugger/hook_helper.rb'
require "pry"

class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

sam = Person.new 'Sam'
hook = PotatoDebugger::Hook.new sam, pry: true
sam.name = 'Potato'
ap sam

binding.pry