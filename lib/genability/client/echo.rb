module Genability
  class Client
    # @private
    module Echo

      def credentials_valid?
        get("echo").status == "success"
      end

      def validate(param_name, param_type)
         get("echo/validate", {param_name => param_type}).results.first
      end

      def raise_error(error_code)
        get("echo/errors/#{error_code}")
      end

    end
  end
end

