require File.expand_path('../../spec_helper', __FILE__)

describe Genability::Client do

  Genability::Configuration::VALID_FORMATS.each do |format|

    context ".new(:format => '#{format}')" do

      before(:all) do
        @options = {:format => format}.merge(configuration_defaults)
        @client = Genability::Client.new(@options)
      end

      context ".add_usage_profile" do

        use_vcr_cassette "usage_profile_add"

        it "should create a new account" do
          @account = @client.add_account(:account_name => 'Ruby Add Usage Profile Test')
          @usage_profile = @client.add_usage_profile(:account_id => @account.account_id)
          @usage_profile.account_id.should == @account.account_id
          @client.delete_account(@account.account_id)
        end

      end

      context ".usage_profiles" do

        use_vcr_cassette "usage_profiles"

        it "should list usage profiles" do
          @account = @client.add_account(:account_name => 'Ruby Usage Profiles Test')
          @usage_profile = @client.add_usage_profile(:account_id => @account.account_id)
          @client.usage_profiles(:account_id => @account.account_id).count.should == 1
          @client.delete_account(@account.account_id)
        end

      end

      context ".usage_profile" do

        use_vcr_cassette "usage_profile"

        it "should return a usage profile" do
          @account = @client.add_account(:account_name => 'Ruby Usage Profile Test')
          @usage_profile = @client.add_usage_profile(:account_id => @account.account_id)
          @client.usage_profile(@usage_profile.profile_id).profile_id.should == @usage_profile.profile_id
          @client.delete_account(@account.account_id)
        end

      end

      context ".add_readings" do

        use_vcr_cassette "readings_add"

        it "should return a usage profile" do
          @account = @client.add_account(:account_name => 'Ruby Add Readings Test')
          @usage_profile = @client.add_usage_profile(:account_id => @account.account_id)
          @readings = @client.add_readings(@usage_profile.profile_id, :readings =>
            [
              {
                :from => "2011-08-01T22:30:00.000-0700",
                :to => "2011-08-01T22:45:00.000-0700",
                :quantity_unit => "kWh",
                :quantity_value => 220
              }
            ]
          )
          @readings.status.should == "success"
          @client.usage_profile(@usage_profile.profile_id).
            reading_data_summaries.count.should == 1
          @client.delete_account(@account.account_id)
        end

      end

    end
  end
end

