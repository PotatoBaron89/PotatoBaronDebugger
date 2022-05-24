module PotatoDebugger
  module DebugHook
    def self.prepended(target)
      puts "Hook has been attached to #{target}"
    end

    def log(value, key, original_value, calling_method, calling_class:, pry: true, bind_snapshot: true)
      return unless @debug

      opts = {}
      opts[:binding] = binding if bind_snapshot
      @__debugger_instance__&.overview << "#{self.name}.name assigned new value #{value} by #{__method__} in #{self.class}"
      @__debugger_instance__&.cache[key] << {
        value_before: original_value,
        value_after: value,
        time: Time.now,
        _calling_method: calling_method,
        _calling_class: calling_class,
        stack_trace: caller.last(10),
        binding: binding
      }.merge(opts)

      if pry
        ap @debug&.cache[key]
        binding.pry
      end
    end
  end
end
