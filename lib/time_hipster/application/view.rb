require 'erb'

module TimeHipster
  module Application
    class View < Struct.new(:template)
      class << self
        def resolve(controller, action_name)
          path = template_path(controller, action_name)
          template = File.exists?(path) ? File.read(path) : 'Ok'
          new(template)
        end

        def template_path(controller, action_name)
          File.join(
            File.expand_path('../views', __FILE__),
            controller.class.to_s.split('::').last.gsub('Controller', '').downcase,
            "#{action_name}.erb"
          )
        end
      end

      def render(assigns)
        ERB.new(template).result(assigns)
      end
    end
  end
end
