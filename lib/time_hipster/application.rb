require File.expand_path('../application/database', __FILE__)
require File.expand_path('../application/router', __FILE__)

require File.expand_path('../application/controller', __FILE__)
Dir[File.expand_path('../application/controllers/*', __FILE__)].map &method(:load)

require File.expand_path('../application/model', __FILE__)
Dir[File.expand_path('../application/models/*', __FILE__)].map &method(:load)

module TimeHipster
  module Application
    class << self
      attr_reader :database

      def root
        @root ||= Pathname.new(File.join(ENV['HOME'], %w[.config tst]))
      end

      def run
        initialize_configuration!
        initialize_database!
      end

      def call(request)
        handle_errors do
          controller_class, action_name, params = Router.new.route(request)
          controller_class.new(params).send(action_name)
        end
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

      def handle_errors
        yield
      rescue Exception => e
        puts e.message
      end
    end
  end
end
