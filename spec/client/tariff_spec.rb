require File.expand_path('../../spec_helper', __FILE__)

describe Genability::Client do

  Genability::Configuration::VALID_FORMATS.each do |format|

    context ".new(:format => '#{format}')" do

      before(:all) do
        @options = {:format => format}.merge(configuration_defaults)
        @client = Genability::Client.new(@options)
      end

      context ".tariffs" do

        use_vcr_cassette "tariffs"

        it "should return an array of tariffs" do
          tariffs = @client.tariffs
          tariffs.should be_an Array
          tariffs.first.tariff_id.should == 79
        end

        it "should accept a string for customerClasses and tariffTypes parameters" do
          @client.tariffs(:customer_classes => 'residential').each do |tariff|
            tariff.customer_class.should =~ /RESIDENTIAL/
          end
        end

        it "should accept an array for customerClasses and tariffTypes parameters" do
          @client.tariffs(:tariff_types => ['default', 'alternative']).each do |tariff|
            tariff.tariff_type.should =~ /(DEFAULT)|(ALTERNATIVE)/
          end
        end

      end

      context ".tariff" do

        use_vcr_cassette "tariff"

        it "should return a tariff" do
          @client.tariff(512).tariff_id.should == 512
        end

      end

    end

  end
end

