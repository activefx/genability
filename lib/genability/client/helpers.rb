require 'json'
require 'time'
require 'chronic'

module Genability
  class Client
    # @private
    module Helpers

      protected

      # @option options [Integer] :page The page number to begin the result
      #   set from. If not specified, this will begin with the first result
      #   set. (Optional)
      # @option options [Integer] :per_page The number of results to return.
      #   If not specified, this will return 25 results. (Optional)
      def pagination_params(options = {})
        {
          'pageStart' => options['pageStart'] || options[:page_start] || options[:page],
          'pageCount' => options['pageCount'] || options[:page_count] || options[:per_page]
        }.delete_if{ |k,v| v.nil? }
      end

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
      def search_params(options = {})
        {
          'search'      => options[:search],
          'searchOn'    => multi_option_handler(options[:search_on]),
          'startsWith'  => convert_to_boolean(options[:starts_with]),
          'endsWith'    => convert_to_boolean(options[:ends_with]),
          'isRegex'     => convert_to_boolean(options[:is_regex]),
          'sortOn'      => options[:sort_on],
          'sortOrder'   => options[:sort_order]
        }.delete_if{ |k,v| v.nil? }
      end

      def convert_to_boolean(value = nil)
        return nil if value.nil? || value.empty?
        value == "false" ? nil : "true"
      end

      def multi_option_handler(value = nil)
        return nil if value.nil?
        if value.is_a?(Array)
          value.collect{|x| x.upcase}.join(',')
        else
          value.upcase
        end
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

