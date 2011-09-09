require File.expand_path('../../spec_helper', __FILE__)

describe Genability::Client do

  Genability::Configuration::VALID_FORMATS.each do |format|

    context ".new(:format => '#{format}')" do

      before(:all) do
        @options = {:format => format}.merge(configuration_defaults)
        @client = Genability::Client.new(@options)
      end

      context ".time_of_uses" do

        use_vcr_cassette "time_of_uses"

        it "should return an the time of uses for a given LSE and touGroupId" do
          time_of_uses = @client.time_of_uses(2756, 1)
          time_of_uses.should be_an Hashie::Mash
          time_of_uses.time_of_uses.count.should == 2
        end

      end

      context ".time_of_use" do

        use_vcr_cassette "time_of_use"

        it "should return the intervals for a given LSE and touGroupId" do
          intervals = @client.time_of_use_intervals(2756, 1)
          intervals.should be_an Array
          intervals.first.tou_group_id.should == 1
        end

      end

    end

  end
end

