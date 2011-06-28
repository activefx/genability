module Genability
  class Client

    module ZipCode

      def zipcode(zipcode)
        get("zipcodes/#{zipcode}").results
      end

    end
  end
end

