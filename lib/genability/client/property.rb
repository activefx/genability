module Genability
  class Client

    module Property

      def property(key_name)
        get("public/properties/#{key_name}").results.first
      end

      def properties(options = {})
        get("public/properties", property_params(options)).results
      end

      private

      def property_params(options)
        {
          'entityId' => options[:entity_id],
          'entityType' => options[:entity_id].nil? ? nil : 'LSE'
        }.delete_if{ |k,v| v.nil? }.merge( pagination_params(options) )
      end

    end
  end
end

