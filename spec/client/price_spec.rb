require File.expand_path('../../spec_helper', __FILE__)

describe Genability::Client do

  Genability::Configuration::VALID_FORMATS.each do |format|

    context ".new(:format => '#{format}')" do

      before(:all) do
        @options = {:format => format}.merge(configuration_defaults)
        @client = Genability::Client.new(@options)
      end

      context ".prices" do

        use_vcr_cassette "prices"

        it "should allow underscored method names" do
          price = @client.prices(520, "2011-07-01T09:38:22.7-0400").first
          price.tariffId.should == price.tariff_id
        end

        it "should return an array of prices" do
          prices = @client.prices(520, "2011-07-01T09:38:22.7-0400")
          prices.should be_an Array
          prices.first.tariff_id.should == 520
        end

        it "should accept toDateTime, territoryId, consumptionAmount and demandAmount parameters" do
          @client.prices(520, "2011-06-24T09:38:22.7-0400",
            :to => "2011-07-01T09:38:22.7-0400", :consumption_amount => 500).
            first.tariff_id.should == 520
        end

      end

    end

  end
end

