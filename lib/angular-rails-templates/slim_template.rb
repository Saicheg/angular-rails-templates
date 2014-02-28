module AngularRailsTemplates

  class SlimTemplate < SimpleDelegator
    attr_reader :engine

    def initialize(context, file)
      @engine = Slim::Template.new(file)
      super(context)
    end

    def render
      require_template_library 'slim'
      @engine.render
    end
  end

end

