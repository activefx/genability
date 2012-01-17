module Genability
  class Client
    # Load Serving Entity (LSE) is the industry term for what most people would call a utility,
    # or an electric company. Since there are different types of electric company, we use the
    # term LSE in our API's. This is a company or other organization that supplies load (electrons,
    # electricity) to a customer. In many cases this is the same company that distributes the
    # electricity too, but in some cases customers can have one company that they buy the load
    # from, and another that operates the distribution system (runs the line to the house,
    # manages the meters etc). Some characteristics and uses:
    #
    #   1. LSE's have territories that they operate in. Sometimes they operate in more than 1.
    #   2. LSE's have tariffs (rate plans) and are central to many of our data structures.
    module LoadServingEntity
      # Returns a list of load serving entities
      #
      # @format :json
      # @authenticated true
      # @rate_limited true
      # @param options [Hash] A customizable set of options.
      # @option options [Integer] :page The page number to begin the result
      #   set from. If not specified, this will begin with the first result
      #   set. (Optional)
      # @option options [Integer] :per_page The number of results to return.
      #   If not specified, this will return 25 results. (Optional)
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
      # @option options [String] :account_id The unique ID of the Account for which
      #   you want to find LSEs. When passed in, the search will look for a territoryId
      #   on the Account and use that to find all LSEs that provide service within that
      #   territory. (Optional)
      # @return [Array] List of load serving entities.
      # @see https://developer.genability.com/documentation/api-reference/public/lse
      # @example Return the first 25 load serving entities
      #   Genability.load_serving_entities
      # @example Return the next 25 load serving entities
      #   Genability.load_serving_entities(:page => 2)
      # @example Return only 10 load serving entities
      #   Genability.load_serving_entities(:per_page => 10)
      # @example Search for load serving entities starting with the letters 'Ka'
      #   Genability.load_serving_entities(:search => 'Ka', :starts_with => 'true')
      # @example Search for load serving entities ending with the word 'Inc'
      #   Genability.load_serving_entities(:search => 'Inc', :ends_with => 'true')
      # @example Search for load serving entities with the word 'Energy'
      #   Genability.load_serving_entities(:search => 'Energy')
      # @example Search for load serving entities with a regular expression
      #   Genability.load_serving_entities(:search => /\w{5,}/)
      def load_serving_entities(options={})
        get("public/lses", lses_params(options)).results
      end

      alias :lses :load_serving_entities

      # Returns details for a single load serving entity
      #
      # @format :json
      # @authenticated true
      # @rate_limited true
      # @param load_serving_entity_id [Integer] Unique Genability ID (primary key) for a Load Serving Entity.
      # @return [Hashie::Mash] Details for a load serving entity.
      # @see https://developer.genability.com/documentation/api-reference/public/lse
      # @example Return the details for Georgia Power Co
      #   Genability.load_serving_entity(2756)
      def load_serving_entity(load_serving_entity_id)
        get("public/lses/#{load_serving_entity_id}").results.first
      end

      alias :lse :load_serving_entity

      private

      def lses_params(options)
        {
          'accountId' => options[:account_id]
        }.delete_if{ |k,v| v.nil? }.
          merge( pagination_params(options) ).
          merge( search_params(options) )
      end

    end
  end
end

