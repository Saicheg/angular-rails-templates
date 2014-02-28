module AngularRailsTemplates

  class HamlTemplate < SimpleDelegator
    attr_reader :engine

    def initialize(context, data)
      @engine = Haml::Engine.new(data)
      super(context)
    end

    def render
      require_template_library 'haml'
      @engine.render
    end
  end

end

