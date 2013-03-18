require File.expand_path('../application/database', __FILE__)
require File.expand_path('../application/router', __FILE__)

require File.expand_path('../application/controller', __FILE__)
Dir[File.expand_path('../application/controllers/*', __FILE__)].map &method(:load)

require File.expand_path('../application/model', __FILE__)
Dir[File.expand_path('../application/models/*', __FILE__)].map &method(:load)

require File.expand_path('../application/view', __FILE__)

module TimeHipster
  module Application
    class << self
      attr_reader :database

      def root
        @root ||= Pathname.new(File.join(ENV['HOME'], %w[.config time_hipster]))
      end

      def run
        initialize_configuration!
        initialize_database!
      end

      def call(request)
        controller_class, action_name, params = Router.new.route(request)
        controller_class.new(params).process(action_name)
      end

      def log(message)
        puts(message) if ENV['VERBOSE']
      end

      private

      def initialize_configuration!
        FileUtils.mkdir_p(root)
      end

      def initialize_database!
        @database = Database.load_file(root + 'db.yml')
      end
    end
  end
end
