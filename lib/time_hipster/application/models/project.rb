module TimeHipster
  module Application
    class Project < Model
      self.attributes = {
        working_periods: []
      }

      def start(timestamp)
        if running?
          raise ArgumentError, "Project '#{id}' already started"
        else
          working_periods << [timestamp]
          save
        end
      end

      def stop(timestamp)
        if running?
          current_working_period << timestamp
          save
        else
          raise ArgumentError, "Project '#{id}' not yet started"
        end
      end

      def running?
        current_working_period && current_working_period.size == 1
      end

      def current_working_period
        working_periods.last
      end
    end
  end
end
