require File.expand_path('../../spec_helper', __FILE__)

describe Genability::Client do

  Genability::Configuration::VALID_FORMATS.each do |format|

    context ".new(:format => '#{format}')" do

      before(:all) do
        @options = {:format => format}.merge(configuration_defaults)
        @client = Genability::Client.new(@options)
      end

      context ".property" do

        use_vcr_cassette "property"

        it "should get a single property by key name" do
          property = @client.property("connectionType")
          property.key_name.should == "connectionType"
        end

      end

      context ".properties" do

        use_vcr_cassette "properties"

        it "should get a list of properties" do
          properties = @client.properties
          properties.first.display_name.should =~ /1000 kWh Block/
        end

        it "should get a list of properties for a specific entity" do
          properties = @client.properties(:entity_id => 734)
          properties.first.entity_id.should == 734
        end

      end

    end

  end
end

