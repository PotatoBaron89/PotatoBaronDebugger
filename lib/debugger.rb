require_relative 'lib/hooks'
require "awesome_print"
require 'time'

module PotatoDebugger
  module HookHelper
    def self.prepended(target)
      puts "Hook has been attached to #{target}"


    end


  private

    def log(value, key, original_value, calling_method)
      @debugger_instance.overview << "#{self.name}.name assigned new value #{value} by #{__method__} in #{self.class}"
      @debugger_instance.cache[key] << {
        value_before: original_value,
        value_after: value,
        time: Time.now,
        _calling_method: calling_method,
        stack_trace: caller[-2]
      }
    end
  end
end
