module PotatoDebugger
  class DebugDecorator
    extend Forwardable

    attr_reader :input
    attr_reader :output
    attr_reader :options
    attr_reader :settings

    def initialize(decorated_debugger, args: nil)
      @debugger = decorated_debugger
      @options = options || Config.new
    end

    def list_changes(*variables, &block)
      @debugger.cache.each do |var|
        next unless variables.include? var[0] || variables.nil?
        key = var[0]

        block.call if block_given?
        output = { key: var[1] }
        ap output
      end
    end

  end
end