require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Genability" do

  context "default values" do
    it { Genability::Configuration::DEFAULT_ADAPTER.should == :net_http }
    it { Genability::Configuration::DEFAULT_APPLICATION_ID.should be_nil }
    it { Genability::Configuration::DEFAULT_APPLICATION_KEY.should be_nil }
    it { Genability::Configuration::DEFAULT_ENDPOINT.should == 'http://api.genability.com/rest/public/' }
    it { Genability::Configuration::DEFAULT_FORMAT.should == :json }
    it { Genability::Configuration::DEFAULT_USER_AGENT.should == 'Genability API Ruby Gem' }
    it { Genability::Configuration::DEFAULT_PROXY.should be_nil }
  end

  context ".client" do
    it "should be a Genability::Client" do
      Genability.client.should be_a Genability::Client
    end
  end

  context ".adapter" do
    it "should return the default adapter" do
       Genability.adapter.should == Genability::Configuration::DEFAULT_ADAPTER
    end
  end

  context ".adapter=" do
    it "should set the adapter" do
      Genability.adapter = :typhoeus
      Genability.adapter.should == :typhoeus
    end
  end

  context ".application_id" do
    it "should return the default application id" do
      Genability.application_id.should == Genability::Configuration::DEFAULT_APPLICATION_ID
    end
  end

  context ".application_id=" do
    it "should set the application id" do
      Genability.application_id = '1234'
      Genability.application_id.should == '1234'
    end
  end

  context ".application_key" do
    it "should return the default application key" do
      Genability.application_key.should == Genability::Configuration::DEFAULT_APPLICATION_KEY
    end
  end

  context ".application_key=" do
    it "should set the application key" do
      Genability.application_key = '5678'
      Genability.application_key.should == '5678'
    end
  end

  context ".endpoint" do
    it "should return the default endpoint" do
      Genability.endpoint.should == Genability::Configuration::DEFAULT_ENDPOINT
    end
  end

  context ".endpoint=" do
    it "should set the endpoint" do
      Genability.endpoint = 'http://tumblr.com'
      Genability.endpoint.should == 'http://tumblr.com'
    end
  end

  context ".format" do
    it "should return the default format" do
      Genability.format.should == Genability::Configuration::DEFAULT_FORMAT
    end
  end

  context ".format=" do
    it "should set the format" do
      Genability.format = 'xml'
      Genability.format.should == 'xml'
    end
  end

  context ".user_agent" do
    it "should return the default user agent" do
      Genability.user_agent.should == Genability::Configuration::DEFAULT_USER_AGENT
    end
  end

  context ".user_agent=" do
    it "should set the user_agent" do
      Genability.user_agent = 'Custom User Agent'
      Genability.user_agent.should == 'Custom User Agent'
    end
  end

  context ".proxy" do
    it "should return the default proxy" do
      Genability.proxy.should == Genability::Configuration::DEFAULT_PROXY
    end
  end

  context ".proxy=" do
    it "should set the proxy" do
      Genability.proxy = 'http://127.0.0.1'
      Genability.proxy.should == 'http://127.0.0.1'
    end
  end

  context ".options" do
    it "should retreive a hash of options and their values" do
      Genability.options.keys.should == Genability::Configuration::VALID_OPTIONS_KEYS
    end
  end

  context ".reset" do
    it "should restore the options to their default values" do
      Genability.adapter = :typhoeus
      Genability.reset
      Genability.adapter.should == Genability::Configuration::DEFAULT_ADAPTER
    end
  end

  context ".configure" do
    Genability::Configuration::VALID_OPTIONS_KEYS.each do |key|
      it "should set the #{key}" do
        Genability.configure do |config|
          config.send("#{key}=", key)
          Genability.send(key).should == key
        end
      end
    end
  end

end

