require File.expand_path('../../spec_helper', __FILE__)

describe Genability::Client do

  Genability::Configuration::VALID_FORMATS.each do |format|

    context ".new(:format => '#{format}')" do

      use_vcr_cassette "echo"

      before(:all) do
        @options = {:format => format}.merge(configuration_defaults)
        @client = Genability::Client.new(@options)
      end

      context ".credentials_valid?" do

        it "should be successful with valid appId and appKey" do
          @client.credentials_valid?.should be_true
        end

      end

      #  context ".validate_date" do

      #    it "should validate a properly formatted date" do
      #      date = @client.send(:format_to_iso8601, "October 26th, 2011")
      #      @client.validate_date(date).should == "hi"
      #    end

      #  end

      context ".raise_error" do

        it "should simulate an error response" do
          lambda do
            @client.raise_error(500)
          end.should raise_error Genability::ServerError
        end

      end

    end
  end
end

