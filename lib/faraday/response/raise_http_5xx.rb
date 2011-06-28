require 'faraday'

# @private
module Faraday
  # @private
  class Response::RaiseHttp5xx < Response::Middleware

    def on_complete(env)
      case env[:status].to_i
      when 500
        raise Genability::ServerError, error_message(env, "Something is wrong on our end. If the problem persists please file a bug report or contact support.")
      when 503
        raise Genability::ServiceUnavailable, error_message(env, "The Genability API is down, please try again later.")
      end
    end

    private

    def error_message(env, body=nil)
      "#{env[:method].to_s.upcase} #{env[:url].to_s}: #{[env[:status].to_s + ':', body].compact.join(' ')}"
    end

  end
end

