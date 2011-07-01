require 'time'
require 'chronic'

module Genability
  class Client
    # @private
    module Helpers

      private

      def pagination_params(options)
        {
          'pageStart' => options['pageStart'] || options[:page_start] || options[:page],
          'pageCount' => options['pageCount'] || options[:page_count] || options[:per_page],
        }.delete_if{ |k,v| v.nil? }
      end

      def convert_to_boolean(value = nil)
        return nil if value.nil? || value.empty?
        "true"
      end

      def format_to_iso8601(date_time = nil)
        if date_time.respond_to?(:iso8601)
          genability_iso8601_converter(date_time)
        else
          parse_and_format_to_iso8601(date_time)
        end
      end

      def parse_and_format_to_iso8601(date_time = nil)
        parsed_date = Chronic.parse(date_time.to_s)
        parsed_date = parsed_date.nil? ? Time.parse(date_time.to_s) : parsed_date
        genability_iso8601_converter(parsed_date)
      rescue
        nil
      end

      def genability_iso8601_converter(date_time = nil)
        date_time.iso8601(1).gsub(/(?<=\-\d{2}):(?=\d{2})/, '')
      rescue
        nil
      end

    end
  end
end

