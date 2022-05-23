require_relative "init"

class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

sam = Person.new 'Sam'
hook = PotatoDebugger::Hook.new sam
sam.name = 'Potato'
ap sam

binding.irb