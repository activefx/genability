#require File.expand_path('../oauth', __FILE__)

module Genability
  # @private
  class API
    include Connection
    include Request
    #include OAuth

    # @private
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    # Creates a new API
    def initialize(options={})
      options = Genability.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

  end
end

