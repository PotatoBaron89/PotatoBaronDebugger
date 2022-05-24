# frozen_string_literal: true

# (C) Samuel O'Donnell 2022
# MIT License

require 'faker'
require "awesome_print"
require "pry"

require './lib/potato_debugger/version'
require './lib/potato_debugger/debug_core'
require './lib/potato_debugger/config'
require './lib/potato_debugger/debug_decorator'
require './lib/potato_debugger/hooks'
require './lib/potato_debugger/debug_hook'


class Person
  attr_accessor :name, :age, :height, :hobbies, :address, :tasks

  def initialize(name: "", age: "", height: 1.85, hobbies: ['Stuff', 'Creating Problems', 'Coding'], address: "123 Fake St",
      tasks: [{ title: "Sample", due_date: "Tomorrow", text: "I'm lazy" }])

    @name     = name
    @age      = age
    @height   = height
    @hobbies  = hobbies
    @address  = address
    @tasks    = tasks
  end
end

module SomeModule
  module AnotherModule
    include SomeModule

    def self.randomizer(times: 20, vals:)

      times.times do
        method_name =  ::Faker::Color.color_name.gsub(" ","_")
        method_name = "#{method_name}"

        AnotherModule.define_singleton_method(method_name) do |values|
          values.map {|_| vals[0].name = ::Faker::TvShows::Simpsons.character }
        end

        AnotherModule.send method_name.to_sym ,vals
        AnotherModule.singleton_class.send :undef_method, method_name
      end
    end
  end
end

sam = Person.new(name: "Sam")
PotatoDebugger::Hook.new sam

SomeModule::AnotherModule.randomizer(vals: [sam, sam.instance_variables])


binding.pry