module TimeHipster
  module Application
    class Controller < Struct.new(:params)
      def process(action_name)
        handle_errors do
          send(action_name)
          View.resolve(self, action_name).render(assigns)
        end
      end

      private

      def handle_errors
        yield
      rescue Exception => e
        e.message
      end

      alias :assigns :binding
    end
  end
end
