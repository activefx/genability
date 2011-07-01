module Genability
  class Client

    module Price

      # fromDateTime Date Date and time of the requested start of the Price. In ISO 8601 format.
      # toDateTime Date Date and time of the requested start of the Price. In ISO 8601 format. (Optional)
      # territoryId Long When specified, rate changes returned will be for the specified Territory. (Optional)
      # consumptionAmount Decimal By default, the rate amount calculation assumes the highest banded level of consumption. When a consumptionAmount is specified, this amount is used in the calculation. (Optional)
      # demandAmount Decimal By default, the rate amount calculation assumes the highest banded level of demand. When a demandAmount is specified, this amount is used in the calculation. (Optional)
      def prices(tariff_id, params = {})
        params["fromDateTime"] = params[:from] if params[:from]
        params["toDateTime"] = params[:to] if params[:to]
        params["territoryId"] = params[:territory_id] if params[:territory_id]
        params["consumptionAmount"] = params[:consumption_amount] if params[:consumption_amount]
        params["demandAmount"] = params[:demand_amount] if params[:demand_amount]
        get("prices/#{tariff_id}", params).results
      end

      private

      def prices_params(options)

      end


    end
  end
end

