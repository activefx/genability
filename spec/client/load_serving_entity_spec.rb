require File.expand_path('../../spec_helper', __FILE__)

describe Genability::Client do

  Genability::Configuration::VALID_FORMATS.each do |format|

    context ".new(:format => '#{format}')" do

      before(:all) do
        @options = {:format => format}.merge(configuration_defaults)
        @client = Genability::Client.new(@options)
      end

      context ".load_serving_entities" do

        use_vcr_cassette "load_serving_entities"

        it "should return an array of load serving entities" do
          lses = @client.load_serving_entities
          lses.should be_an Array
          lses.first.name.should_not be_nil
        end

        it "should return 25 results by default" do
          @client.load_serving_entities.count.should == 25
        end

        it "should accept a pageCount parameter" do
          @client.load_serving_entities(:per_page => 10).count.should == 10
        end

        it "should accept a pageStart parameter" do
          lses = @client.load_serving_entities(:page => 2)
          lses.should be_an Array
          lses.count.should == 25
          lses.first.name.should_not be_nil
        end

        it "should accept a startsWithWildCard parameter" do
          lses = @client.load_serving_entities(:starts_with => 'In')
          lses.should_not be_empty
          lses.each do |result|
            result.name.should =~ /^In/
          end
        end

        it "should accept an endsWithWildCard parameter" do
          lses = @client.load_serving_entities(:ends_with => 'Inc')
          lses.should_not be_empty
          lses.each do |result|
            result.name.should =~ /Inc$/
          end
        end

        it "should accept a containsWildCard parameter" do
          lses = @client.load_serving_entities(:search_string => 'Energy')
          lses.should_not be_empty
          lses.each do |result|
            result.name.should =~ /Energy/
          end
        end

      end

      context ".load_serving_entity" do

        use_vcr_cassette "load_serving_entity"

        it "should return a load serving entity" do
          lse = @client.load_serving_entity(2756)
          lse.should be_a Hashie::Mash
          lse.name.should == "Georgia Power Co"
        end

      end

    end

  end
end

