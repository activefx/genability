module Genability
  # Wrapper for the Genability REST API
  class Client < API
    require 'genability/client/load_serving_entity'
    require 'genability/client/price'
    require 'genability/client/season'
    require 'genability/client/tariff'
    require 'genability/client/territory'
    require 'genability/client/time_of_use'
    require 'genability/client/zip_code'

    include Genability::Client::LoadServingEntity
    include Genability::Client::Price
    include Genability::Client::Season
    include Genability::Client::Tariff
    include Genability::Client::Territory
    include Genability::Client::TimeOfUse
    include Genability::Client::ZipCode
  end
end

