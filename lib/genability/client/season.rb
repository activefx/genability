module Genability
  class Client

    module Season

      def seasons(load_serving_entity_id)
        get("seasons", { :lseId => load_serving_entity_id }).results
      end

    end
  end
end

