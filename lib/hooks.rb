require_relative '../debugger'
require "awesome_print"

module PotatoDebugger
  class Hook
    include PotatoDebugger


    def initialize(klass, *args)
      @cache = {}
      @class = klass
      @overview ||= []
      @options = {}

      args.each {|arg, value| @options[arg] = value }

      klass.instance_variables.each do |instance_var|
        method_name = "#{instance_var}="
        method_name[0] = ''
        attribute = instance_var.to_s[1..25]

        @cache[attribute.to_sym] = []

        klass.define_singleton_method("tracked_#{attribute}") { ap @debugger_instance.cache[attribute] }


        HookHelper.define_method(method_name) do |value|
          log(value, attribute.to_sym, send(attribute), __method__)
        end

        klass.define_singleton_method("tracked") { |key, *opts|
          options = {}
          opts.each {|o| options[o] = true}

          if opts.empty?
            ap @debugger_instance.cache[key]
          else
            ap @debugger_instance.cache[key].filter do |e|
              options.key? e
            end
          end
        }
      end

      klass.instance_variable_set(:@debugger_instance, self)
      klass.class.prepend(HookHelper)

      self.class.attr_reader :cache, :overview
    end
  end
end