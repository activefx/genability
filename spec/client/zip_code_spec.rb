require File.expand_path('../../spec_helper', __FILE__)

describe Genability::Client do

  Genability::Configuration::VALID_FORMATS.each do |format|

    context ".new(:format => '#{format}')" do

      before(:all) do
        @options = {:format => format}.merge(configuration_defaults)
        @client = Genability::Client.new(@options)
      end

      context ".zipcode" do

        use_vcr_cassette "zipcode"

        it "should return details for a given zipcode" do
          zipcode = @client.zipcode('48322')
          zipcode.should be_an Hashie::Mash
          zipcode.city.should == "WEST BLOOMFIELD"
        end

      end

    end

  end
end

