require File.expand_path('../../spec_helper', __FILE__)

describe Genability::Client do

  Genability::Configuration::VALID_FORMATS.each do |format|

    context ".new(:format => '#{format}')" do

      before(:all) do
        @options = {:format => format}.merge(configuration_defaults)
        @client = Genability::Client.new(@options)
      end

      context ".load_serving_entities" do

        use_vcr_cassette "load_serving_entity"

        it "should return an array of load serving entities" do
          @client.load_serving_entities.should be_an Array
          @client.load_serving_entities.first.name.should == "Infinite Energy Inc"
        end

        it "should return 25 results by default" do
          @client.load_serving_entities.count.should == 25
        end

        it "should accept a pageCount parameter" do
          @client.load_serving_entities(:per_page => 10).count.should == 10
        end

        it "should accept a pageStart parameter" do
          @client.load_serving_entities(:page => 2).first.name.should == "Nooruddin Investments LLC"
        end

      end

    end

  end
end

