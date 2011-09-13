module Genability
  class Client
    # The Calculate service basically calculates the cost of electricity for a
    # given rate/pricing plan. This can be used to calculate a bill, "what-if"
    # different rates, levels of usage, energy efficiency measures or any other
    # electrical activity. It gives a total cost for a period of time. (Note
    # that if you want a price/rate for a specific point in time, then look at
    # the Price service.)
    module Calculate

      # @overload calculate_metadata(tariff_id, from_date_time, to_date_time, options = {})
      #   Calling the URL as a HTTP GET will return the "inputs" required to accurately
      #   calculate the cost for a given period. It essentially gives you the meta-data
      #   for what to pass into the calculate method, and as such provides a template
      #   for the payload of the HTTP POST.
      #   @param tariff_id [Integer] Unique Genability ID (primary key) for a tariff.
      #   @param from_date_time [DateTime, String] Starting date and time for this Calculate request.
      #     In ISO 8601 format. Will attempt to use the Chronic gem to parse if a string is used.
      #   @param to_date_time [DateTime, String] End date and time for this Calculate request.
      #     In ISO 8601 format. Will attempt to use the Chronic gem to parse if a string is used.
      #   @param options [Hash] A customizable set of options.
      #   @option options [Integer] :territory_id The territory ID of where the usage consumption occurred. (Required for most CA tariffs.)
      #   @return [Array] Array of TariffInput for consumption.
      #   @example Return the inputs required to accurately calculate the cost for a given period
      #     Genability.calculate_metadata(512, "2011-06-16T19:00:00.0-0400", "2011-08-01T00:00:00.0-0400")
      # @format :json
      # @authenticated true
      # @rate_limited true
      # @see https://developer.genability.com/documentation/api-reference/pricing/calculate
      def calculate_metadata(tariff_id, from, to, options = {})
        get("alpha/calculate/#{tariff_id}", calculate_meta_params(from, to, options)).results
      end

      # Calculate the cost of electricity for a given rate/pricing plan.
      # @overload calculate(tariff_id, from_date_time, to_date_time, tariff_inputs, options = {})
      # @see https://developer.genability.com/documentation/api-reference/pricing/calculate
      def calculate(tariff_id, from, to, tariff_inputs, options = {})
        post(
          "alpha/calculate/#{tariff_id}",
          calculate_params(from, to, tariff_inputs, options)
        ).results.first
      end

      private

      def calculate_params(from, to, tariff_inputs, options)
        {
          "fromDateTime" => format_to_iso8601(from),
          "toDateTime" => format_to_iso8601(to),
          "territoryId" => options[:territory_id],
          "detailLevel" => options[:detail_level],
          "tariffInputs" => tariff_input_params(tariff_inputs)
        }.
        delete_if{ |k,v| v.nil? }.
        merge({ "appId" => Genability.application_id,
                "appKey" => Genability.application_key }).
        to_json
      end

      def tariff_input_params(tariff_inputs)
        [].tap do |a|
          if tariff_inputs.is_a?(Hash)
            a << convert_tariff_input_params(tariff_inputs)
          elsif tariff_inputs.is_a?(Array)
            tariff_inputs.each do |ti|
              a << convert_tariff_input_params(tariff_inputs)
            end
          else
            raise Genability::InvalidTariffInput
          end
        end
      end

      def convert_tariff_input_params(tariff_input)
        raise Genability::InvalidTariffInput unless tariff_input.is_a?(Hash)
        {
          "key" => tariff_input[:input_key],
          "fromDateTime" => tariff_input[:from],
          "toDateTime" => tariff_input[:to],
          "unit" => tariff_input[:unit],
          "value" => tariff_input[:input_value]
        }
      end

      def calculate_meta_params(from, to, options)
        {
          "fromDateTime" => format_to_iso8601(from),
          "toDateTime" => format_to_iso8601(to),
          "territoryId" => options[:territory_id]
        }.delete_if{ |k,v| v.nil? }
      end

    end
  end
end

