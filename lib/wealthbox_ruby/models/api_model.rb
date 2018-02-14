module WealthboxRuby
  module Models
    class APIModel < Base
      class << self

        def json_attributes(*args)
          @@json_attrs = args
        end

        def json_attrs
          @@json_attrs
        end
      end

      def initialize(attrs = {}, client = nil)
        super attrs
        @client = client
      end

      def json_params
        self.class.json_attrs.inject({}) do |params, jsa|
          val = self.send(jsa)

          next params if val.nil?
          next params if val.is_a?(Array) && val.length == 0
          next params if val.is_a?(Hash) && !val.keys.any?

          params[jsa] = val
          params
        end
      end
    end
  end
end
