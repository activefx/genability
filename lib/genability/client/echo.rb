module Genability
  class Client

    module Echo

      def credentials_valid?
        get("echo").status == "success"
      end

      #  def validate_date(date)
      #    get("echo/validatedate", {"dateToValidate" => date}).results.first
      #  end

      def raise_error(error_code)
        get("echo/errors/#{error_code}")
      end

    end
  end
end

