module AngularRailsTemplates
  class HamlTemplate < Template
    def initialize_engine
      require_template_library 'haml'
    end

    def prepare
      @engine = Haml::Engine.new(data)
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

