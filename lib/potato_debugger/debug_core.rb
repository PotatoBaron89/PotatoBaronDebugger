module PotatoDebugger
  class DebugCore
    attr_accessor :hook, :debug, :klass, :overview, :cache, :options

    def initialize(hook, klass, *args)
      @hook = hook
      @klass = klass
      @options = Config.new(*args)
      @cache = {}
      @overview ||= []

      klass.define_singleton_method("potato_debugger") { @debug }
      klass.define_singleton_method("_debug") { @debug }
      klass.define_singleton_method("options") { @debug.changes(*variables, &block) }
      klass.define_singleton_method("options") { @debug.options }
      klass.define_singleton_method("temp") { binding.pry }

      klass.instance_variables.each do |instance_var|
        method_name = "#{instance_var}="
        method_name[0] = ''
        attribute = instance_var.to_s[1..25]

        @cache[attribute.to_sym] = []

        klass.define_singleton_method("tracked_#{attribute}") { ap @debug.cache[attribute] }

        DebugHook.define_method(method_name) do |value|
          log(value, attribute.to_sym, send(attribute), __method__,
              calling_class: self.singleton_class.__binding__.receiver,
              pry: @__debugger_instance__&.options.debug_on_tracked_change?,
              bind_snapshot:  @__debugger_instance__.options.bind_scopes_with_tracked_change?
          )
        end

        klass.define_singleton_method("tracked") { |key, *opts|
          options = {}
          opts.each {|o| options[o] = true}

          if opts.empty?
            ap @__debugger_instance__.cache[key]
          else
            ap @__debugger_instance__.cache[key].filter do |e|
              options.key? e
            end
          end
        }
      end

      klass.instance_variable_set(:@debug, DebugDecorator.new(self))
      klass.instance_variable_set(:@__debugger_instance__, self)
    end
  end
end