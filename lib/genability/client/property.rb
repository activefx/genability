module Genability
  class Client
    # Properties are metadata associated with a tariff. They are frequently
    # used to determine applicability for a particular set of rates within a
    # tariff. For example, the property cityLimits is used when a tariff has
    # different rates based on whether the consumer lives inside or outside
    # the city limits.
    module Property
      # This allows you to retrieve one Property using its keyname. This is
      # particularly useful when using the Calculator as it may require you to
      # specify certain applicability values prior to making the calculation.
      #
      # @format :json
      # @authenticated true
      # @rate_limited true
      # @param key_name [String] Property key name
      # @return [Hashie::Mash] Details for a property.
      # @see https://developer.genability.com/documentation/api-reference/public/property
      def property(key_name)
        get("public/properties/#{key_name}").results.first
      end

      # This returns a list of Properties based on a search criteria. The result
      # set is an array of Property objects in the standard response format.
      #
      # @format :json
      # @authenticated true
      # @rate_limited true
      # @param options [Hash] A customizable set of options.
      # @option options [Integer] :entity_id Filters the result set to only include
      #   Properties that belong to this entityId. EntityType must also be specified,
      #   otherwise this is ignored (Optional).
      # @option options [String] :entity_type Filters the result set to only include
      #   Properties that belong to this entityType. EntityId must also be specified,
      #   otherwise this is ignored. Currently the only supported value is 'LSE' (Optional)
      # @return [Array] Array of property objects.
      # @see https://developer.genability.com/documentation/api-reference/public/property
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

