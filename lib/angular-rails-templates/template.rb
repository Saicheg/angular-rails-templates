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
  $templateCache.put(#{logical_template_path.inspect}, #{data.to_json});
}]);
      EOS
    end

    private
    def logical_template_path(scope)
      path = scope.logical_path
      path.gsub!(Regexp.new("^#{configuration.ignore_prefix}"), "")
      filename = basename.split(".").first
      directory = File.dirname path
      "#{directory}/#{filename}"
    end

    def configuration
      ::Rails.configuration.angular_templates
    end
  end
end
