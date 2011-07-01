module Genability
  class Client
    # Most LSEs will charge different rates depending on the time of year. Each
    # LSE defines the times of the year themselves but typically they are split
    # into Summer and Winter. We refer to these as the Seasons of an LSE. We
    # also define Season Groups, which contain more than Seasons and which
    # altogether span a full calendar year. Each Season belongs to one and
    # only one Season Group.
    module Season
      # Returns a list of season groups for a given load serving entity.
      #
      # @format :json
      # @authenticated true
      # @rate_limited true
      # @param load_serving_entity_id [Integer] Unique Genability ID (primary key) for a Load Serving Entity.
      # @return [Array] list of season groups for a load serving entity.
      # @see https://developer.genability.com/documentation/api-reference/public/season
      # @example Return a list of season groups for Pacific Gas & Electric Co
      #   Genability.seasons(734)
      def seasons(load_serving_entity_id)
        get("seasons", { :lseId => load_serving_entity_id }).results
      end

    end
  end
end

