module Genability
  class Client

    module UsageProfile

      def add_usage_profile(options = {})
        post( "beta/usage/profiles?appId=#{application_id}&appKey=#{application_key}",
              add_usage_profile_params(options)
            ).results.first
      end

      def usage_profiles(options = {})
        get("beta/usage/profiles", usage_profiles_params(options)).results
      end

      def usage_profile(usage_profile_id, options = {})
        get("beta/usage/profiles/#{usage_profile_id}", usage_profile_params(options)).results.first
      end

      def add_readings(usage_profile_id, options = {})
        post( "beta/usage/profiles/#{usage_profile_id}/readings?appId=#{application_id}&appKey=#{application_key}",
              readings_params(options[:readings])
            )
      end


      private

      def add_usage_profile_params(options)
        usage_profiles_params(options).to_json
      end

      def usage_profiles_params(options)
        {
          "accountId" => options[:account_id]
        }.
        delete_if{ |k,v| v.nil? }
      end

      def usage_profile_params(options)
        {
          "fromDateTime" => format_to_iso8601(options[:from] || options[:from_date_time]),
          "toDateTime" => format_to_iso8601(options[:to] || options[:to_date_time]),
          "populateUsageData" => convert_to_boolean(options[:populate_usage_data]),
          "groupBy" => options[:group_by],
          "clipBy" => options[:clip_by]
        }.delete_if{ |k,v| v.nil? }
      end

      def readings_params(readings)
        {
          "readings" => [].tap do |a|
            case readings
            when Hash
              a << convert_readings(readings)
            when Array
              readings.each do |r|
                a << convert_readings(r)
              end
            else
              raise Genability::InvalidInput
            end
          end
        }.to_json
      end

      def convert_readings(options)
        {
          "fromDateTime" => format_to_iso8601(options[:from] || options[:from_date_time]),
          "toDateTime" => format_to_iso8601(options[:to] || options[:to_date_time]),
          "quantityUnit" => options[:quantity_unit],
          "quantityValue" => options[:quantity_value]
        }.delete_if{ |k,v| v.nil? }
      end

    end
  end
end

