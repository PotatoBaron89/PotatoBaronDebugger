module PotatoDebugger
  class Hook
    include PotatoDebugger

    attr_accessor :debug, :attrs

    def initialize(klass)
      @debug = DebugCore.new(self, klass)
      @attrs = @debug.hook.debug.cache

      klass.class.prepend(DebugHook)
      self.class.attr_reader :cache, :overview

    end
  end
end