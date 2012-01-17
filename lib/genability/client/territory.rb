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
      # @param territory_id [Integer] Unique Genability ID (primary key) for
      #   each Territory.
      # @param options [Hash] A customizable set of options.
      # @option options [Boolean] :populate_items If true, this returns a List
      #   of TerritoryItems for each Territory in the result set. (Optional;
      #   defaults to false)
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
      # @option options [Integer] :lse_id Filter tariffs for a specific Load
      #   Serving Entity. (Optional)
      # @option options [Boolean] :populate_items If true, this returns a List
      #   of TerritoryItems for each Territory in the result set. (Optional;
      #   defaults to false)
      # @option options [Integer] :master_tariff_id Filters the result set to
      #   only include territories covered by this master tariff id. (Optional)
      # @option options [String] :contains_item_type Filters the result set to
      #   include a particular type of territory. Possible values are: CITY,
      #   ZIPCODE, STATE, COUNTY. (Optional)
      # @option options [String] :contains_item_value Filters the Types by
      #   this value. e.g. 94115 when searching for types of ZIPCODE. (Optional)
      # @option options [String] :usage_type Filters the result set to only
      #   include territories of the specified usageType. Possible values are:
      #   SERVICE, TARIFF. (Optional)
      # @option options [String] :search The string of text to search on. This
      #   can also be a regular expression, in which case you should set the
      #   'isRegex' flag to true. (Optional)
      # @option options [String] :search_on Comma separated list of fields to
      #   query on. When searchOn is specified, the text provided in the search
      #   string field will be searched within these fields. The list of fields
      #   to search on depend on the entity being searched for. Read the documentation
      #   for the entity for more details on the fields that can be searched, and
      #   the default fields to be searched if searchOn is not specified. (Optional)
      # @option options [Boolean] :starts_with When true, the search will only
      #   return results that begin with the specified search string. Otherwise,
      #   any match of the search string will be returned as a result. Default is
      #   false. (Optional)
      # @option options [Boolean] :ends_with When true, the search will only return
      #   results that end with the specified search string. Otherwise, any match of
      #   the search string will be returned as a result. Default is false. (Optional)
      # @option options [Boolean] :is_regex When true, the provided search string
      #   will be regarded as a regular expression and the search will return results
      #   matching the regular expression. Default is false. (Optional)
      # @option options [String] :sort_on Comma separated list of fields to sort on.
      #   This can also be input via Array Inputs (see above). (Optional)
      # @option options [String] :sort_order Comma separated list of ordering.
      #   Possible values are 'ASC' and 'DESC'. Default is 'ASC'. If your sortOn
      #   contains multiple fields and you would like to order fields individually,
      #   you can pass in a comma separated list here (or use Array Inputs, see above).
      #   For example, if your sortOn contained 5 fields, and your sortOrder contained
      #   'ASC, DESC, DESC', these would be applied to the first three items in the sortOn
      #   field. The remaining two would default to ASC. (Optional)
      # @return [Array] List of territories.
      # @see https://developer.genability.com/documentation/api-reference/public/territory
      # @example Return a list of territories for Pacific Gas & Electric Co
      #   Genability.territories(:lse_id => 734)
      # @example Get a Territory ID from a Zipcode
      #   Genability.territories(:lse_id => 734, :contains_item_type => 'ZIPCODE', :contains_item_value => 94115)
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
          'containsItemValue' => options[:contains_item_value],
          'usageType' => options[:usage_type]
        }.delete_if{ |k,v| v.nil? }.
          merge( territory_params(options) ).
          merge( search_params(options) ).
          merge( pagination_params(options) )
      end

    end
  end
end

