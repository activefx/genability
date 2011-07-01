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
      # @option options [Integer] :lse_id Filter tariffs for a specific Load Serving Entity. (Optional)
      # @option options [Date] :effective_on  Only tariffs that are effective on this date. (Optional)
      # @option options [String, Array] :customer_classes Only include these customer classes. Choices are: RESIDENTIAL, GENERAL. (Optional)
      # @option options [String, Array] :tariff_types Only include these tariff types. Choices are: DEFAULT, ALTERNATIVE, OPTIONAL_EXTRA, RIDER. (Optional)
      # @option options [String] :zip_code Return tariffs for this zip or post code. (Optional)
      # @option options [Boolean] :populate_rates Populates the rate details for the returned Tariffs. (Optional)
      # @option options [Integer] :page The page number to begin the result set from. If not specified, this will begin with the first result set. (Optional)
      # @option options [Integer] :per_page The number of results to return. If not specified, this will return 25 results. (Optional)
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
        get("tariffs", tariffs_params(options)).results
      end

      # Returns one tariff.
      #
      # @format :json
      # @authenticated true
      # @rate_limited true
      # @param tariff_id [Integer] Unique Genability ID (primary key) for a tariff.
      # @param options [Hash] A customizable set of options.
      # @option options [Boolean] :populate_rates Populates the rate details for the returned Tariff. (Optional)
      # @return [Hashie::Mash] A tariff.
      # @see https://developer.genability.com/documentation/api-reference/public/tariff
      # @example Return the residential serice tariff for Georgia Power Co
      #   Genability.tariff(512)
      def tariff(tariff_id, options = {})
        get("tariffs/#{tariff_id}", tariff_params(options)).results.first
      end

      private

      def tariffs_params(options)
        {
          'lseId' => options[:lse_id],
          'effectiveOn' => options[:effective_on],
          'customerClasses' => multi_option_handler(options[:customer_classes]),
          'tariffTypes' => multi_option_handler(options[:tariff_types]),
          'zipCode' => options[:zip_code]
        }.delete_if{ |k,v| v.nil? }.
          merge( tariff_params(options) ).
          merge( pagination_params(options) )
      end

      def tariff_params(options)
        {
          'populateRates' => convert_to_boolean(options[:populate_rates])
        }.delete_if{ |k,v| v.nil? }
      end

    end
  end
end

