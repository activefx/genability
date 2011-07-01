require File.expand_path('../../spec_helper', __FILE__)

describe Genability::Client do

  Genability::Configuration::VALID_FORMATS.each do |format|

    context ".new(:format => '#{format}')" do

      before(:all) do
        @options = {:format => format}.merge(configuration_defaults)
        @client = Genability::Client.new(@options)
      end

      context ".seasons" do

        use_vcr_cassette "seasons"

        it "should return a list of season groups" do
          seasons = @client.seasons(734)
          seasons.should be_an Array
          seasons.first.seasons.count.should == 2
        end

      end

    end

  end
end

