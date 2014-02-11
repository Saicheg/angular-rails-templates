require 'sprockets'
require 'sprockets/engines'

module AngularRailsTemplates
  class Template < Tilt::Template
    def self.default_mime_type
      'application/javascript'
    end

    def prepare; end

    def evaluate(scope, locals, &block)
      module_name           = configuration.module_name
      logical_template_path = logical_template_path(scope)

      <<-EOS
window.AngularRailsTemplates || (window.AngularRailsTemplates = angular.module(#{module_name.inspect}, []));

window.AngularRailsTemplates.run(["$templateCache",function($templateCache) {
  $templateCache.put(#{logical_template_path.inspect}, #{content.to_json});
}]);
      EOS
    end

    private

    def content
      ext = File.extname(file)

      return Slim::Template.new(file).render if slim?(ext)
      return Haml::Engine.new(file).render if haml?(ext)

      data
    end

    def slim?(ext)
      ext =~ /ast/
    end

    def haml?(ext)
      ext =~ /aht/
    end

    def logical_template_path(scope)
      path = scope.logical_path
      path.gsub!(Regexp.new("^#{configuration.ignore_prefix}"), "")
      "#{path}.html"
    end

    def configuration
      ::Rails.configuration.angular_templates
    end
  end
end

