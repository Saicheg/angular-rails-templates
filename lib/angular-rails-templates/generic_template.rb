module AngularRailsTemplates
  class GenericTemplate < Template
    def prepare ; end

    def evaluate(scope, locals, &block)
      logical_template_path = logical_template_path(scope)

      script_template(
        module_name,
        logical_template_path.inspect,
        data
      )
    end
  end
end

