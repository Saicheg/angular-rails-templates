module AngularRailsTemplates
  class GenericTemplate < Template
    def prepare ; end

    def evaluate(scope, locals, &block)
      logical_template_path = logical_template_path(scope)
      script_template(logical_template_path, data)
    end
  end
end

