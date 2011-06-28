module Genability
  class Client

    module TimeOfUse

      def time_of_uses(load_serving_entity_id, time_of_use_group_id)
        params["pageStart"] = params[:page] if params[:page]
        params["pageCount"] = params[:per_page] if params[:per_page]
        get("time_of_uses/#{load_serving_entity_id}/#{time_of_use_group_id}", params).results
      end

      alias :tou :time_of_uses

      # fromDateTime Date ISO 8601 format for the starting date and time of the requested Intervals. Defaults to current day and time if not specified. (Optional)
      # toDateTime Date ISO 8601 format for the ending date and time of the requested Intervals. Defaults to one week after the fromDateTime. (Optional)
      def time_of_use_intervals(load_serving_entity_id, time_of_use_group_id, params = {})
        params["fromDateTime"] = params[:from] if params[:from]
        params["toDateTime"] = params[:to] if params[:to]
        get("time_of_uses/#{load_serving_entity_id}/#{time_of_use_group_id}/intervals", params).results
      end

      alias :tou_intervals :time_of_use_intervals
      alias :intervals :time_of_use_intervals

    end
  end
end

