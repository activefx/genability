module Genability
  class Client
    # Most LSEs will charge different rates depending on the time of year. Each
    # LSE defines the times of the year themselves but typically they are split
    # into Summer and Winter. We refer to these as the Seasons of an LSE. We
    # also define Season Groups, which contain more than Seasons and which
    # altogether span a full calendar year. Each Season belongs to one and
    # only one Season Group.
    module Season
      # Returns a list of season groups for a given load serving entity.
      #
      # @format :json
      # @authenticated true
      # @rate_limited true
      # @param load_serving_entity_id [Integer] Unique Genability ID (primary key) for a Load Serving Entity.
      # @param options [Hash] A customizable set of options.
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
      # @return [Array] list of season groups for a load serving entity.
      # @see https://developer.genability.com/documentation/api-reference/public/season
      # @example Return a list of season groups for Pacific Gas & Electric Co
      #   Genability.seasons(734)
      def seasons(load_serving_entity_id, options = {})
        get("public/seasons", season_params(load_serving_entity_id, options)).results
      end

      private

      def season_params(load_serving_entity_id, options)
        { :lseId => load_serving_entity_id }.
          delete_if{ |k,v| v.nil? }.
          merge( search_params(options) )
      end

    end
  end
end

