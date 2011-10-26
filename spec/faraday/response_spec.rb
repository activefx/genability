require File.expand_path('../../spec_helper', __FILE__)

describe Faraday::Response do

  before do
    @client = Genability::Client.new({:application_id => 'ValidAppID', :application_key => 'ValidAppKey'})
  end

  {
    400 => Genability::BadRequest,
    403 => Genability::Forbidden,
    404 => Genability::NotFound,
    500 => Genability::ServerError,
    503 => Genability::ServiceUnavailable
  }.each do |status, exception|
    context "when HTTP status is #{status}" do

      before(:each) do
        stub_get('public/lses?appId=ValidAppID&appKey=ValidAppKey').
          to_return(:status => status)
      end

      it "should raise #{exception.name} error" do
        lambda do
          @client.load_serving_entities()
        end.should raise_error(exception)
      end
    end
  end
end

