require 'faraday_middleware'
require 'faraday/response/raise_http_4xx'
require 'faraday/response/raise_http_5xx'

module Genability
  # @private
  module Connection
    private

    def connection(raw=false)
      # raise if id or key is missing
      options = {
        :headers => {'Accept' => "application/#{format}; charset=utf-8", 'User-Agent' => user_agent},
        :proxy => proxy,
        :ssl => {:verify => false},
        :url => endpoint,
        :params => {
          :appId => application_id,
          :appKey => application_key
        }
      }

      Faraday::Connection.new(options) do |connection|
        #connection.use Faraday::Request::OAuth2, client_id, access_token
        connection.use Faraday::Response::RaiseHttp4xx
        connection.use Faraday::Response::Mashify unless raw
        unless raw
          case format.to_s.downcase
          when 'json'
            connection.use Faraday::Response::ParseJson
          end
        end
        connection.use Faraday::Response::RaiseHttp5xx
        connection.adapter(adapter)
      end
    end
  end
end

