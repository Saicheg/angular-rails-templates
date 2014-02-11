require 'sprockets'
require 'sprockets/engines'

module AngularRailsTemplates
  class Template < Tilt::Template
    def self.default_mime_type
      'application/javascript'
    end

    protected

    def logical_template_path(scope)
      path = scope.logical_path
      path.gsub!(Regexp.new("^#{configuration.ignore_prefix}"), "")
      "#{path}.html"
    end

    def module_name
      configuration.module_name.inspect
    end

    def configuration
      ::Rails.configuration.angular_templates
    end

    def script_template(*arguments)
      script_template = <<-EOS
window.AngularRailsTemplates || (window.AngularRailsTemplates = angular.module(%s, []));

window.AngularRailsTemplates.run(["$templateCache",function($templateCache) {
  $templateCache.put(%s, %s);
}]);
      EOS

      sprintf(script_template, *arguments)
    end
  end
end

