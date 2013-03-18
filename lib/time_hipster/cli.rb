require 'thor'

require File.expand_path('../application', __FILE__)

module TimeHipster
  class CLI < Thor
    desc 'start PROJECT-ID', 'Start time tracking of PROJECT-ID'
    def start_project(project_id)
      call(project_id, :start)
    end

    desc 'stop PROJECT-ID', 'Stop time tracking of PROJECT-ID'
    def stop_project(project_id)
      call(project_id, :stop)
    end

    private

    def call(project_id, action_name)
      Application.run
      Application.call("/projects/#{project_id}/#{action_name}")
    end
  end
end
