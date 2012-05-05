require 'faraday'
require 'addressable/uri'
require 'pry'
# @private
module Faraday
  # @private
  class Request::UrlEncodingFix < Faraday::Middleware

    def call(env)
      url = env[:url].to_s
      url.gsub!(/%3A/, ':')
      env[:url] = Addressable::URI.parse(url)
      @app.call(env)
    end

  end
end

