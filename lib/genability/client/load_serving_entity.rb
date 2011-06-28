module Genability
  class Client

    module LoadServingEntity

      # pageStart number The page number to begin the result set from. If not specified, this will begin with the first result set. (Optional)
      # pageCount number The number of results to return. If not specified, this will return 25 results. (Optional)
      # wildCardText String Phrase for searching the names of LSEs (Optional)
      # startsWithWildCard Boolean Indicates the wildCardText should match the start of the name (Optional)
      # endsWithWildCard Boolean Indicates the wildCardText should match the end of the name (Optional)
      # containsWildCard Boolean Indicates the wildCardText should be somewhere in the middle of the name (Optional)
      def load_serving_entities(params={})
        params["pageStart"] = params[:page] if params[:page]
        params["pageCount"] = params[:per_page] if params[:per_page]
        get("lses", params).results
      end

      alias :lses :load_serving_entities

      def load_serving_entity(id)
        get("lses/#{id}").results
      end

      alias :lse :load_serving_entity

    end
  end
end

