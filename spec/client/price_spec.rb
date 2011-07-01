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

        it "should return a price" do
          @client.prices(520).should be_an Hashie::Mash
          @client.tariffId.should == 520
        end

      end

    end

  end
end

