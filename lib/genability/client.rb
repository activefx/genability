module Genability
  # Wrapper for the Genability REST API
  class Client < API
    require 'genability/client/helpers'
    require 'genability/client/account'
    require 'genability/client/calculate'
    require 'genability/client/echo'
    require 'genability/client/load_serving_entity'
    require 'genability/client/price'
    require 'genability/client/property'
    require 'genability/client/season'
    require 'genability/client/tariff'
    require 'genability/client/territory'
    require 'genability/client/time_of_use'
    require 'genability/client/usage_profile'
    require 'genability/client/zip_code'

    include Genability::Client::Helpers

    include Genability::Client::Account
    include Genability::Client::Calculate
    include Genability::Client::Echo
    include Genability::Client::LoadServingEntity
    include Genability::Client::Price
    include Genability::Client::Property
    include Genability::Client::Season
    include Genability::Client::Tariff
    include Genability::Client::Territory
    include Genability::Client::TimeOfUse
    include Genability::Client::UsageProfile
    include Genability::Client::ZipCode
  end
end

