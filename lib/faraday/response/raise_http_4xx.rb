require 'faraday'

# @private
module Faraday
  # @private
  class Response::RaiseHttp4xx < Response::Middleware

    def on_complete(env)
      case env[:status].to_i
      when 400
        raise Genability::BadRequest, error_message(env)
      when 403
        raise Genability::Forbidden, error_message(env)
      when 404
        raise Genability::NotFound, error_message(env)
      end
    end

    private

    def error_message(env)
      "#{env[:method].to_s.upcase} #{env[:url].to_s} STATUS:#{env[:status]} #{error_body(env[:body])}"
    end

    def error_body(body)
      if body.nil?
        nil
      else
        "ERRORS:#{body.count}#{error_details(body)}"
      end
    end

    def error_details(body)
      msg = ""
      body.results.each_with_index do |result, i|
        msg << " #{i+1}[code:#{result.code} object_name:#{result.objectName} property_name:#{result.propertyName} message:#{result.message}]"
      end
      msg
    end


  end
end

