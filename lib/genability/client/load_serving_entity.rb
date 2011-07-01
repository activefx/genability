module Genability
  class Client
    # Load Serving Entity (LSE) is the industry term for what most people would call a utility,
    # or an electric company. Since there are different types of electric company, we use the
    # term LSE in our API's. This is a company or other organization that supplies load (electrons,
    # electricity) to a customer. In many cases this is the same company that distributes the
    # electricity too, but in some cases customers can have one company that they buy the load
    # from, and another that operates the distribution system (runs the line to the house,
    # manages the meters etc). Some characteristics and uses:
    #
    #   1. LSE's have territories that they operate in. Sometimes they operate in more than 1.
    #   2. LSE's have tariffs (rate plans) and are central to many of our data structures.
    module LoadServingEntity
      # Returns a list of load serving entities
      #
      # @format :json
      # @authenticated true
      # @rate_limited false
      # @param options [Hash] A customizable set of options.
      # @option options [String] :starts_with  Indicates the search phrase should match the start of the name. (Optional)
      # @option options [String] :ends_with Indicates the search phrase should match the end of the name. (Optional)
      # @option options [String] :contains Indicates the search phrase should be somewhere in the middle of the name. (Optional)
      # @option options [Integer] :page The page number to begin the result set from. If not specified, this will begin with the first result set. (Optional)
      # @option options [Integer] :per_page The number of results to return. If not specified, this will return 25 results. (Optional)
      # @return [Array] List of load serving entities.
      # @see https://developer.genability.com/documentation/api-reference/public/lse
      # @example Return the first 25 load serving entities
      #   Genability.load_serving_entities
      # @example Return the next 25 load serving entities
      #   Genability.load_serving_entities(:page => 2)
      # @example Return only 10 load serving entities
      #   Genability.load_serving_entities(:per_page => 10)
      # @example Search for load serving entities with the name 'Infinite'
      #   Genability.load_serving_entities(:search => 'Infinite')
      # @example Search for load serving entities starting with the letters 'Ka'
      #   Genability.load_serving_entities(:starts_with => 'Ka')
      # @example Search for load serving entities ending with the word 'Inc'
      #   Genability.load_serving_entities(:ends_with => 'Inc')
      # @example Search for load serving entities with the word 'Energy' somewhere in the name
      #   Genability.load_serving_entities(:contains => 'Energy')
      def load_serving_entities(options={})
        get("lses", lses_params(options)).results
      end

      alias :lses :load_serving_entities

      # Returns details for a single load serving entity
      #
      # @format :json
      # @authenticated true
      # @rate_limited false
      # @param load_serving_entity_id [Integer] Unique Genability ID (primary key) for a Load Serving Entity.
      # @return [Hashie::Mash] Details for a load serving entity.
      # @see https://developer.genability.com/documentation/api-reference/public/lse
      # @example Return the details for Georgia Power Co
      #   Genability.load_serving_entity(2756)
      def load_serving_entity(load_serving_entity_id)
        get("lses/#{load_serving_entity_id}").results.first
      end

      alias :lse :load_serving_entity

      private

      def lses_params(options)
        {
          'wildCardText' => options[:contains] || options[:starts_with] || options[:ends_with],
          'startsWithWildCard' => convert_to_boolean(options[:starts_with]),
          'endsWithWildCard' => convert_to_boolean(options[:ends_with]),
          'containsWildCard' => convert_to_boolean(options[:contains])
        }.delete_if{ |k,v| v.nil? }.merge( pagination_params(options) )
      end

    end
  end
end

