module Genability
  class Client

    module Tariff

      # populateRates Boolean Populates the rate details for this Tariff
      def tariff(tariff_id, params = {})
        params["populateRates"] = params[:populate_rates] if params[:populate_rates]
        get("tariffs/#{tariff_id}", params).results
      end

      # lseId Long Filter tariffs for a specific LSE (Optional)
      # effectiveOn Date Only tariffs that are effective on this date (Optional)
      # customerClasses String[] Only include these customer classes. Choices are: RESIDENTIAL, GENERAL (Optional)
      # tariffTypes String[] Only include these tariff types. Choices are: DEFAULT, ALTERNATIVE, OPTIONAL_EXTRA, RIDER (Optional)
      # zipCode String Return tariffs for this zip or post code (Optional)
      def tariffs(params = {})
        params["pageStart"] = params[:page] if params[:page]
        params["pageCount"] = params[:per_page] if params[:per_page]
        params["lseId"] = params[:lse_id] if params[:lse_id]
        params["effectiveOn"] = params[:effective_on] if params[:effective_on]
        params["customerClasses"] = params[:customer_classes] if params[:customer_classes]
        params["tariffTypes"] = params[:tariff_types] if params[:tariff_types]
        params["zipCode"] = params[:zip_code] if params[:zip_code]
        get("tariffs", params).results
      end


    end
  end
end

