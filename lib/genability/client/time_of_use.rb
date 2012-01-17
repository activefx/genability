module Genability
  class Client
    # Many tariffs have pricing that depends on the time of day the energy
    # is being used. We call these times the Time of Use for a tariff.
    # The most common examples are On Peak and Off Peak. Some examples
    # here may help:
    #
    #   1. Within a single Time of Use, e.g. On Peak, the price for a
    #      tariff will always be the same.
    #   2. Within a single Time of Use, e.g. On Peak, you may have multiple
    #      Periods. A Period is a range of days and times that this TOU applies to.
    module TimeOfUse

      # Returns a particular time of use group using its time of use group ID and
      # the load serving entity ID.
      #
      # @format :json
      # @authenticated true
      # @rate_limited true
      # @param load_serving_entity_id [Integer] Unique Genability ID (primary key)
      #   for a Load Serving Entity.
      # @param time_of_use_group_id [Integer] Genability ID (primary key) for this
      #   Time of Use Group. This is unique within the LSE, not across LSE's so you
      #   will always need to specify the LSE ID when requested a TOU Group.
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
      # @return [Hashie::Mash] Return the time of uses for a load serving entity.
      # @see https://developer.genability.com/documentation/api-reference/public/time-of-use
      # @example Return the time of use group for Georgia Power Co
      #   Genability.time_of_uses(2756, 1)
      def time_of_uses(load_serving_entity_id, time_of_use_group_id, options = {})
        get("public/timeofuses/#{load_serving_entity_id}/#{time_of_use_group_id}", tou_params(options)).results.first
      end

      alias :tou :time_of_uses

      # Returns all the Intervals for a Time of Use Group for an optionally specified
      # from and to date and time range. Defaults to current time if fromDateTime is
      # not specified and to a one week look ahead window if toDateTime is not specified.
      #
      # @format :json
      # @authenticated true
      # @rate_limited true
      # @param load_serving_entity_id [Integer] Unique Genability ID (primary key) for
      #   a Load Serving Entity.
      # @param time_of_use_group_id [Integer] Genability ID (primary key) for this Time
      #   of Use Group. This is unique within the LSE, not across LSE's so you will
      #   always need to specify the LSE ID when requested a TOU Group.
      # @param options [Hash] A customizable set of options.
      # @option options [DateTime] :from ISO 8601 format for the starting date and
      #   time of the requested Intervals. Defaults to current day and time if
      #   not specified. (Optional)
      # @option options [DateTime] :to ISO 8601 format for the ending date and
      #   time of the requested Intervals. Defaults to one week after the
      #   fromDateTime. (Optional)
      # @return [Array] Returns all the Intervals for a Time of Use Group.
      # @see https://developer.genability.com/documentation/api-reference/public/time-of-use
      # @example Return the intervals for the time of use group for Georgia Power Co
      #   Genability.time_of_use_intervals(2756, 1)
      def time_of_use_intervals(load_serving_entity_id, time_of_use_group_id, options = {})
        get("public/timeofuses/#{load_serving_entity_id}/#{time_of_use_group_id}/intervals", interval_params(options)).results
      end

      alias :tou_intervals :time_of_use_intervals
      alias :intervals :time_of_use_intervals
      alias :toui :time_of_use_intervals

      private

      def tou_params(options)
        search_params(options)
      end

      def interval_params(options)
        {
          'fromDateTime' => format_to_iso8601(options[:from]),
          'toDateTime' => format_to_iso8601(options[:to])
        }.delete_if{ |k,v| v.nil? }
      end

    end
  end
end

