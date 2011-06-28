module Genability
  class Client

    module Territory

      # populateItems Boolean If true, this returns a List of TerritoryItems for the Territory. (Optional; defaults to false)
      def territory(territory_id, params = {})
        params["populateItems"] = params[:populate_items] if params[:populate_items]
        get("territories/#{territory_id}", params).results
      end

      # lseId Long Filters the result set to only include territories within this LSE Id (Optional).
      # populateItems Boolean If true, this returns a List of TerritoryItems for each Territory in the result set. (Optional; defaults to false)
      # masterTariffId Long Filters the result set to only include territories covered by this master tariff id. (Optional)
      # containsItemType String Filters the result set to include a particular type of territory. Possible values are: CITY, ZIPCODE, STATE, COUNTY. (Optional)
      # containsItemValue String Filters the Types by this value. e.g. 94115 when searching for types of ZIPCODE (Optional)
      def territories(params)
        params["pageStart"] = params[:page] if params[:page]
        params["pageCount"] = params[:per_page] if params[:per_page]
        params["lseId"] = params[:lse_id] if params[:lse_id]
        params["populateItems"] = params[:populate_items] if params[:populate_items]
        params["masterTariffId"] = params[:tariff_id] if params[:tariff_id]
        params["containsItemType"] = params[:item_type] if params[:item_type]
        params["containsItemValue"] = params[:item_value] if params[:item_value]
        get("territories", params).results
      end

    end
  end
end

