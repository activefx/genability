The Genability Ruby Gem
====================
A Ruby wrapper for the Genability power pricing and related APIs - learn more at [https://developer.genability.com](https://developer.genability.com)

Installation
------------
    gem install genability

Documentation
-------------
[http://rdoc.info/gems/genability](http://rdoc.info/gems/genability)

Usage Examples
--------------
    require "rubygems"
    require "genability"

    # Configure during client initialization
    client = Genability::Client.new(:application_id = 'ValidAppId', :application_key => 'ValidAppKey')

    # Or use the block configuration method
    # register an app at https://developer.genability.com
    Genability.configure do |config|
      config.application_id = 'ValidAppId'
      config.application_key = 'ValidAppKey'
    end

    # Get a list of load serving entities
    Genability.load_serving_entities

    # Get one load serving entity
    Genability.load_serving_entity(2756)

    # Get a list of tariffs
    Genability.tariffs

    # Get one tariff
    Genability.tariff(512)

    # Get the prices for a specified tariff
    Genability.prices(520)

    # Get the territories for a load serving entity
    Genability.territories(:lse_id => 734)

    # Get the details of one territory
    Genability.territory(3539)

    # Get a list of seasons for a load serving entity
    Genability.seasons(734)

    # Get a particular time of use group for a given load serving entity
    Genability.time_of_uses(2756, 1)

    # Get the intervals for the particular time of use group of a given load serving entity
    Genability.time_of_use_intervals(2756, 1)

    # Get information about a zipcode
    Genability.zipcode('48322')

    # Please see the documentation for available options and the tests for additional examples


Contributing to Genability
-------------------------
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add documentation
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Copyright
---------
Copyright (c) 2011 Matthew Solt.
See [LICENSE](https://github.com/activefx/genability/blob/master/LICENSE.md) for details.

