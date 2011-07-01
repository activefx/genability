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

      # Returns a particular time of use group using its time of use group ID and the load serving entity ID.
      #
      # @format :json
      # @authenticated true
      # @rate_limited true
      # @param load_serving_entity_id [Integer] Unique Genability ID (primary key) for a Load Serving Entity.
      # @param time_of_use_group_id [Integer] Genability ID (primary key) for this Time of Use Group. This is unique within the LSE, not across LSE's so you will always need to specify the LSE ID when requested a TOU Group.
      # @return [Hashie::Mash] Return the time of uses for a load serving entity.
      # @see https://developer.genability.com/documentation/api-reference/public/time-of-use
      # @example Return the time of use group for Georgia Power Co
      #   Genability.time_of_uses(2756, 1)
      def time_of_uses(load_serving_entity_id, time_of_use_group_id)
        get("timeofuses/#{load_serving_entity_id}/#{time_of_use_group_id}").results.first
      end

      alias :tou :time_of_uses

      # Returns all the Intervals for a Time of Use Group for an optionally specified
      # from and to date and time range. Defaults to current time if fromDateTime is
      # not specified and to a one week look ahead window if toDateTime is not specified.
      #
      # @format :json
      # @authenticated true
      # @rate_limited true
      # @param load_serving_entity_id [Integer] Unique Genability ID (primary key) for a Load Serving Entity.
      # @param time_of_use_group_id [Integer] Genability ID (primary key) for this Time of Use Group. This is unique within the LSE, not across LSE's so you will always need to specify the LSE ID when requested a TOU Group.
      # @param options [Hash] A customizable set of options.
      # @option options [DateTime] :from ISO 8601 format for the starting date and time of the requested Intervals. Defaults to current day and time if not specified. (Optional)
      # @option options [DateTime] :to ISO 8601 format for the ending date and time of the requested Intervals. Defaults to one week after the fromDateTime. (Optional)
      # @return [Array] Returns all the Intervals for a Time of Use Group.
      # @see https://developer.genability.com/documentation/api-reference/public/time-of-use
      # @example Return the intervals for the time of use group for Georgia Power Co
      #   Genability.time_of_use_intervals(2756, 1)
      def time_of_use_intervals(load_serving_entity_id, time_of_use_group_id, options = {})
        get("timeofuses/#{load_serving_entity_id}/#{time_of_use_group_id}/intervals", interval_params(options)).results
      end

      alias :tou_intervals :time_of_use_intervals
      alias :intervals :time_of_use_intervals

      private

      def interval_params(options)
        {
          'fromDateTime' => format_to_iso8601(options[:from]),
          'toDateTime' => format_to_iso8601(options[:to])
        }.delete_if{ |k,v| v.nil? }
      end

    end
  end
end

