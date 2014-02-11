module AngularRailsTemplates
  class SlimTemplate < Template
    def initialize_engine
      require_template_library 'slim'
    end

    def prepare
      @engine = Slim::Template.new(file)
    end

    def evaluate(scope, locals, &block)
      logical_template_path = logical_template_path(scope)

      script_template(
        module_name,
        logical_template_path.inspect,
        @engine.render
      )
    end
  end
end

