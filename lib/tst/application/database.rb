require 'yaml'

module Tst
  module Application
    class Database < Struct.new(:path)
      def self.load_file(path)
        new(path).tap do |db|
          db.create! unless db.exists?
          db.reload!
        end
      end

      def create!
        File.open(path, 'w') { |f| f.write({}.to_yaml) }
      end

      def exists?
        File.exist?(path)
      end

      def read(key)
        @data[key]
      end

      def write(key, value)
        @data[key] = value
        commit!
      end

      def reload!
        @data = YAML.load_file(path)
        Application.log "Reload #{@data.inspect}"
      end

      def commit!
        File.open(path, 'w') { |f| f.write(@data.to_yaml) }
        Application.log "Commit #{@data.inspect}"
        reload!
      end
    end
  end
end
