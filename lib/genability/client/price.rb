module Genability
  class Client
    # Given a start date and time, Price returns the price of a specified Tariff as well as
    # all the changes in price over the course of the next week. Optional parameters allow
    # you to retrieve more specific pricing based on Territory and Consumption and Demand usage.
    module Price
      # @overload prices(tariff_id, from_date_time = Time.now.iso8601, options = {})
      #   Returns the price of the specified tariff for the passed in date and time,
      #   and also the changes in price for this tariff for the next week.
      #   @param tariff_id [Integer] Unique Genability ID (primary key) for a tariff.
      #   @param from_date_time [DateTime, String] Date and time of the requested start of the Price.
      #     In ISO 8601 format. Will attempt to use the Chronic gem to parse if a string is used.
      #     (Required, but can be omitted to default to Time.now.iso8601)
      #   @param options [Hash] A customizable set of options.
      #   @option options [DateTime, String] :to Date and time of the requested end of the Price.
      #     In ISO 8601 format. Will attempt to use the Chronic gem to parse if a string is used. (Optional)
      #   @option options [Integer] :territory_id When specified, rate changes returned will be for the specified Territory. (Optional)
      #   @option options [Float] :consumption_amount By default, the rate amount calculation assumes the highest banded level of consumption. When a consumption amount is specified, this amount is used in the calculation. (Optional)
      #   @option options [Float] :demand_amount By default, the rate amount calculation assumes the highest banded level of demand. When a demand amount is specified, this amount is used in the calculation. (Optional)
      #   @return [Array] Array of charge types for the specified tariff, each with the price for the passed in date and time, and also the changes in price for this tariff for the next week.
      #   @example Various examples for retrieving the price(s) of tariff number 520 (Pacific Gas & Electric Co Residential Time-Of-Use Service E-6)
      #     Genability.prices(520)
      #     Genability.prices(520, :consumption_amount => 500)
      #     Genability.prices(520, "2011-06-13T00:00:00.0-070")
      #     Genability.prices(520, Date.yesterday)
      #     Genability.prices(520, "Last friday at 6:45pm", :to => "yesterday afternoon", :consumption_amount => 500)
      # @format :json
      # @authenticated true
      # @rate_limited true
      # @see https://developer.genability.com/documentation/api-reference/public/price
      def prices(tariff_id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        from_date_time = args.first || Time.now
        get("public/prices/#{tariff_id}", prices_params(from_date_time, options)).results
      end

      private

      def prices_params(from_date_time, options)
        {
          "fromDateTime" => format_to_iso8601(from_date_time),
          "toDateTime" => format_to_iso8601(options[:to]),
          "territoryId" => options[:territory_id],
          "consumptionAmount" => options[:consumption_amount],
          "demandAmount" => options[:demand_amount]
        }.delete_if{ |k,v| v.nil? }
      end


    end
  end
end

