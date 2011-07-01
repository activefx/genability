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

      def convert_to_boolean(value)
        return nil if value.nil? || value.empty?
        "true"
      end

    end
  end
end

