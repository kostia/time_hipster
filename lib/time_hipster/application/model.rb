require 'ostruct'

module TimeHipster
  module Application
    class Model < OpenStruct
      class << self
        attr_accessor :attributes

        def find(id)
          data = database.read(path(id)) || {}
          data[:id] = id
          attributes.each_pair { |attribute, default_value| data[attribute] ||= default_value }
          new(data)
        end

        def save(instance)
          database.write(path(instance.id), instance.serialize)
        end

        private

        def path(id)
          "#{self}/#{id}"
        end

        def database
          Application.database
        end
      end

      def save
        self.class.save(self)
      end

      def serialize
        {}.tap do |hash|
          self.class.attributes.keys.each do |attribute|
            hash[attribute] = send(attribute)
          end
        end
      end
    end
  end
end
