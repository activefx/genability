require File.expand_path('../../spec_helper', __FILE__)

describe Genability::Client do

  Genability::Configuration::VALID_FORMATS.each do |format|

    context ".new(:format => '#{format}')" do

      before(:all) do
        @options = {:format => format}.merge(configuration_defaults)
        @client = Genability::Client.new(@options)
      end

      # ISO 8601 date format with a syntax of:
      # yyyy-MM-dd'T'HH:mm:ss.SSSZ
      # ex. 2011-06-13T14:30:00.0-0700
      # All fields must be specified even if they are zero. The .SSS
      # are the milliseconds and the Z is the GMT time zone offset.
      context ".format_to_iso8601" do

        it "should format dates to ISO 8601" do
          @client.send(:format_to_iso8601, Time.now).
            should =~ /\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{1,3}-\d{4}/
        end

      end

    end

  end

end

