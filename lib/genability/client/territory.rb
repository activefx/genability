module Genability
  class Client
    # Territories define the areas of coverage for Load Serving Entities
    # and in some cases for individual tariffs. The areas of coverage can
    # be at these levels:
    #
    #   1. State
    #   2. County
    #   3. City
    #   4. Zip Code
    #
    # Territories can have one of these two usage types:
    #
    #   1. Service - defines the areas where this LSE provides service
    #   2. Tariff - defines the areas where a particular tariff rate applies
    #      to. These types of territories are typically defined by the LSE.
    #
    # We define a Service Territory for each state that an LSE provides
    # coverage. The usageType attribute specifies how this definition
    # is done, either at the State, County, City or Zip Code level.
    module Territory

      # Returns one territory.
      #
      # @format :json
      # @authenticated true
      # @rate_limited true
      # @param territory_id [Integer] Unique Genability ID (primary key) for each Territory.
      # @param options [Hash] A customizable set of options.
      # @option options [Boolean] :populate_items If true, this returns a List of TerritoryItems for each Territory in the result set. (Optional; defaults to false)
      # @return [Hashie::Mash] Details for one territory.
      # @see https://developer.genability.com/documentation/api-reference/public/territory
      # @example Return territory Baseline Region V for Pacific Gas & Electric Co
      #   Genability.territory(3539)
      def territory(territory_id, options = {})
        get("public/territories/#{territory_id}", territory_params(options)).results.first
      end

      # Returns a list of territories.
      #
      # @format :json
      # @authenticated true
      # @rate_limited true
      # @param options [Hash] A customizable set of options.
      # @option options [Integer] :lse_id Filter tariffs for a specific Load Serving Entity. (Optional)
      # @option options [Boolean] :populate_items If true, this returns a List of TerritoryItems for each Territory in the result set. (Optional; defaults to false)
      # @option options [Integer] :master_tariff_id Filters the result set to only include territories covered by this master tariff id. (Optional)
      # @option options [String] :contains_item_type Filters the result set to include a particular type of territory. Possible values are: CITY, ZIPCODE, STATE, COUNTY. (Optional)
      # @option options [String] :contains_item_value Filters the Types by this value. e.g. 94115 when searching for types of ZIPCODE. (Optional)
      # @return [Array] List of territories.
      # @see https://developer.genability.com/documentation/api-reference/public/territory
      # @example Return a list of territories for Pacific Gas & Electric Co
      #   Genability.territories(:lse_id => 734)
      def territories(options = {})
        get("public/territories", territories_params(options)).results
      end

      private

      def territory_params(options)
        {
          'populateItems' => convert_to_boolean(options[:populate_items])
        }.delete_if{ |k,v| v.nil? }
      end

      def territories_params(options)
        {
          'lseId' => options[:lse_id],
          'masterTariffId' => options[:master_tariff_id],
          'containsItemType' => options[:contains_item_type],
          'containsItemValue' => options[:contains_item_value]
        }.delete_if{ |k,v| v.nil? }.
          merge( territory_params(options) ).
          merge( pagination_params(options) )
      end

    end
  end
end

