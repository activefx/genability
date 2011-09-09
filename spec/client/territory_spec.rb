require File.expand_path('../../spec_helper', __FILE__)

describe Genability::Client do

  Genability::Configuration::VALID_FORMATS.each do |format|

    context ".new(:format => '#{format}')" do

      before(:all) do
        @options = {:format => format}.merge(configuration_defaults)
        @client = Genability::Client.new(@options)
      end

      context ".territories" do

        use_vcr_cassette "territories"

        it "should return an array of territories" do
          territories = @client.territories(:lse_id => 734)
          territories.should be_an Array
          territories.first.territory_id.should == 807
        end

      end

      context ".territory" do

        use_vcr_cassette "territory"

        it "should return a territory" do
          territory = @client.territory(3539)
          territory.should be_a Hashie::Mash
          territory.lse_id.should == 734
        end

      end

    end

  end
end

