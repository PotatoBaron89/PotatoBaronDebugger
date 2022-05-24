module PotatoDebugger
  class Config
    attr_reader :track, :misc

    def initialize(
      track: :instance_vars,
      debug_on_tracked_change: false,
      bind_scopes_with_tracked_change: true
    )
      @track = track
      @misc = {
        debug_on_tracked_change: debug_on_tracked_change,
        bind_scopes_with_tracked_change: bind_scopes_with_tracked_change,
      }

      @misc.each do |attr, _|
        self.define_singleton_method("#{attr}?") { @misc[attr]}
      end
    end
  end
end