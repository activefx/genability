require File.expand_path('../../spec_helper', __FILE__)

describe Genability::Client do

  Genability::Configuration::VALID_FORMATS.each do |format|

    context ".new(:format => '#{format}')" do

      before(:all) do
        @options = {:format => format}.merge(configuration_defaults)
        @client = Genability::Client.new(@options)
      end

      context ".calculate_metadata" do

        use_vcr_cassette "calculate_metadata"

        it "should return the inputs required to use the calculate method" do
          metadata = @client.calculate_metadata(
                       512, "2011-06-16T19:00:00.0-0400", "2011-08-01T00:00:00.0-0400"
                     ).first
          metadata.unit.should == "kwh"
        end

      end

      context ".calculate" do

        use_vcr_cassette "calculate"

        it "should calculate the total cost" do
          calc = @client.calculate(
            512,
            "Monday, September 1st, 2011",
            "Monday, September 10th, 2011",
            {
              :input_key => "consumption",
              :from => "2011-08-01T00:00:00.000-0700",
              :to => "2011-09-01T00:00:00.000-0700",
              :unit => "kWh",
              :input_value => 220
            }
          )
          calc.tariff_name.should == "Residential Service"
        end

        it "should not allow invalid tariff inputs" do
          lambda do
            @client.calculate(
              512,
              "Monday, September 1st, 2011",
              "Monday, September 10th, 2011",
              "InvalidTariffInput"
              )
          end.should raise_error(Genability::InvalidTariffInput)
        end

      end

    end

  end
end

