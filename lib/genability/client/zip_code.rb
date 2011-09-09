module Genability
  class Client
    # Zip Code provides a set of information useful for display purposes. For example,
    # if you are interested in tariffs for zip code 48322, you can retrieve additional
    # information such as the city and county name as well as the latitude and
    # longitude coordinates.
    module ZipCode

      # Returns the details for a zip code.
      #
      # @format :json
      # @authenticated true
      # @rate_limited true
      # @param zipcode [String] 5 digit zipcode
      # @return [Hashie::Mash] Return the details for a particular zipcode.
      # @see https://developer.genability.com/documentation/api-reference/public/zip-code
      # @example Return the details for the 48322 zipcode
      #   Genability.zipcode('48322')
      def zipcode(zipcode)
        get("public/zipcodes/#{zipcode}").results.first
      end

      alias :zip_code :zipcode

    end
  end
end

