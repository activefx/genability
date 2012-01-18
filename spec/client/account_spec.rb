require File.expand_path('../../spec_helper', __FILE__)

describe Genability::Client do

  Genability::Configuration::VALID_FORMATS.each do |format|

    context ".new(:format => '#{format}')" do

      before(:all) do
        @options = {:format => format}.merge(configuration_defaults)
        @client = Genability::Client.new(@options)
      end

      context ".add_account" do

        use_vcr_cassette "account_add"

        it "should create a new account" do
          @account = @client.add_account(:account_name => 'Ruby Add Account Test')
          @account.account_name.should == 'Ruby Add Account Test'
          @client.delete_account(@account.account_id)
        end

      end

      context ".delete_account" do

        use_vcr_cassette "account_delete"

        it "should delete an account" do
          @account = @client.add_account(:account_name => 'Ruby Delete Account Test')
          @client.delete_account(@account.account_id).status.should == 'success'
        end

      end

      context ".accounts" do

        use_vcr_cassette "accounts"

        it "should return a list of accounts" do
          @account = @client.add_account(:account_name => 'Ruby Accounts Test')
          @account.account_name.should == 'Ruby Accounts Test'
          @client.accounts(:search => 'Ruby Accounts Test').count.should == 1
          @client.delete_account(@account.account_id)
        end

      end

      context ".account" do

        use_vcr_cassette "account"

        it "should return a an account" do
          @account = @client.add_account(:account_name => 'Ruby Account Test')
          @client.account(@account.account_id).account_name.should == 'Ruby Account Test'
          @client.delete_account(@account.account_id)
        end

      end

    end
  end
end

