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
                       512,                           # masterTariffId
                       "2011-06-16T19:00:00.0-0400",  # toDateTime
                       "2011-08-01T00:00:00.0-0400",  # fromDateTime
                       {
                         :connection_type => "Primary Connection",
                         :city_limits => "Inside"
                       }
                     ).first
          debugger
          metadata.unit.should == "kwh"
        end

      end

      context ".calculate" do

        use_vcr_cassette "calculate"
#"results\":[{
#\"keyName\":\"consumption\",\"dataType\":\"DECIMAL\",
#\"fromDateTime\":\"2011-06-16T19:00:00.000-0400\",
#\"toDateTime\":\"2011-07-01T00:00:00.000-0400\",
#\"unit\":\"kwh\"},
#{\"keyName\":\"cityLimits\",#\"dataType\":\"CHOICE\",
#\"fromDateTime\":\"2011-06-16T19:00:00.000-0400\",
#\"toDateTime\":\"2011-08-01T00:00:00.000-0400\",
##\"dataValue\":\"Inside\"},
#{\"keyName\":\"connectionType\",\"dataType\":\"CHOICE\",
#\"fromDateTime\":\"2011-06-16T19:00:00.000-0400\",
##\"toDateTime\":\"2011-08-01T00:00:00.000-0400\",
#\"dataValue\":\"Primary Connection\"},
#{\"keyName\":\"consumption\",
##\"dataType\":\"DECIMAL\",
#\"fromDateTime\":\"2011-07-01T00:00:00.000-0400\",
#\"toDateTime\":\"2011-08-01T00:00:00.000-0400\",
#\"unit\":\"kwh\"}]}"
        it "should calculate the total cost" do
          calc = @client.calculate(
            512,                                         # masterTariffId
            "Monday, September 1st, 2011",               # fromDateTime
            "Monday, September 10th, 2011",              # toDateTime
            {                                            # tariffInputs
              :key_name => "consumption",
              :from => "2011-08-01T00:00:00.000-0700",
              :to => "2011-09-01T00:00:00.000-0700",
              :unit => "kWh"#,
              #:input_value => 220
            }#,
            #{                                            # optional parameters
            #  :connection_type => "Primary Connection"
            #}
          )
          calc.tariff_name.should == "Residential Service"
          calc.items.first.rate_name.should == "Basic Service Charge"
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

