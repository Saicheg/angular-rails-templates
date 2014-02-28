module AngularRailsTemplates

  DefaultTemplate = Struct.new(:data) do
    def render
      data
    end
  end

end

