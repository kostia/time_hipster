module TimeHipster
  module Application
    class Router
      NotFound = Class.new(ArgumentError)

      def route(request)
        case request
        when /^\/projects\/(.*)\/(.*)/i
          controller_class = ProjectsController
          action_name = $2
          params = {id: $1}
          [controller_class, action_name, params]
        else
          raise NotFound, "No route for #{url} found"
        end
      end
    end
  end
end
