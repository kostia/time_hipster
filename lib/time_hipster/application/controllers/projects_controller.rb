module TimeHipster
  module Application
    class ProjectsController < Controller
      def start
        load_project
        @project.start(current_timestamp)
        :ok
      end

      def stop
        load_project
        @project.stop(current_timestamp)
        :ok
      end

      private

      def load_project
        @project = Project.find(params[:id])
      end

      def current_timestamp
        Time.now
      end
    end
  end
end
