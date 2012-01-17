module Genability
  class Client
    # Tariffs are rate plans for electricity. They describe who the plan applies
    # to (service and applicability), what the charges are, and other information
    # about this electricity service:
    #
    #   1. We have residential tariffs currently. General tariffs (commercial &
    #      industrial and speciality tariffs) are coming soon.
    #   2. You can specify whether you want the tariff fully populated, or whether
    #      you just want a sub section of the data (to avoid charges and to speed
    #      up your queries).
    module Tariff
      # Returns a list of tariffs.
      #
      # @format :json
      # @authenticated true
      # @rate_limited true
      # @param options [Hash] A customizable set of options.
      # @option options [Integer] :lse_id Filter tariffs for a specific Load Serving
      #   Entity. (Optional)
      # @option options [Date] :effective_on  Only tariffs that are effective on
      #   this date. (Optional)
      # @option options [Date] :from Only include tariffs that are effective on or
      #   after this date (Optional)
      # @option options [Date] :to Only include tariffs that are effective on or
      #   before this date (Optional)
      # @option options [String, Array] :customer_classes Only include these customer
      #   classes. Choices are: RESIDENTIAL, GENERAL. (Optional)
      # @option options [String, Array] :tariff_types Only include these tariff types.
      #   Choices are: DEFAULT, ALTERNATIVE, OPTIONAL_EXTRA, RIDER. (Optional)
      # @option options [String] :zip_code Return tariffs for this zip or post
      #   code. (Optional)
      # @option options [Boolean] :populate_rates Populates the rate details for the
      #   returned Tariff. (Optional)
      # @option options [Boolean] :populate_properties Populates the properties
      #   for the returned Tariffs (Optional; defaults to false)
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
      # @return [Array] List of tariffs.
      # @see https://developer.genability.com/documentation/api-reference/public/tariff
      # @example Return the first 25 tariffs
      #   Genability.tariffs
      # @example Return the tariffs for Georgia Power Co
      #   Genability.tariffs(:lse_id => 2756)
      # @example Return only residential tariffs
      #   Genability.tariffs(:customer_classes => 'residential')
      # @example Return only default and alternative tariff types
      #   Genability.tariffs(:tariff_types => ['default', 'alternative'])
      def tariffs(options = {})
        get("public/tariffs", tariffs_params(options)).results
      end

      # Returns one tariff.
      #
      # @format :json
      # @authenticated true
      # @rate_limited true
      # @param tariff_id [Integer] Unique Genability ID (primary key) for a tariff.
      # @param options [Hash] A customizable set of options.
      # @option options [Boolean] :populate_rates Populates the rate details for the
      #   returned Tariff. (Optional)
      # @option options [Boolean] :populate_properties Populates the properties
      #   for the returned Tariffs (Optional; defaults to false)
      # @return [Hashie::Mash] A tariff.
      # @see https://developer.genability.com/documentation/api-reference/public/tariff
      # @example Return the residential serice tariff for Georgia Power Co
      #   Genability.tariff(512)
      def tariff(tariff_id, options = {})
        get("public/tariffs/#{tariff_id}", tariff_params(options)).results.first
      end

      private

      def tariffs_params(options)
        {
          'lseId' => options[:lse_id],
          'effectiveOn' => format_to_iso8601(options[:effective_on]),
          'fromDateTime' => format_to_iso8601(options[:from] || options[:from_date_time]),
          "toDateTime" => format_to_iso8601(options[:to] || options[:to_date_time]),
          'customerClasses' => multi_option_handler(options[:customer_classes]),
          'tariffTypes' => multi_option_handler(options[:tariff_types]),
          'zipCode' => options[:zip_code],
          'accountId' => options[:account_id]
        }.delete_if{ |k,v| v.nil? }.
          merge( tariff_params(options) ).
          merge( search_params(options) ).
          merge( pagination_params(options) )
      end

      def tariff_params(options)
        {
          'populateRates' => convert_to_boolean(options[:populate_rates]),
          'populateProperties' => convert_to_boolean(options[:populate_properties])
        }.delete_if{ |k,v| v.nil? }
      end

    end
  end
end

