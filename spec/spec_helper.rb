$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'webmock/rspec'
require 'genability'
require 'vcr'

CONFIGURATION_DEFAULTS = begin
  YAML::load_file("#{File.dirname(__FILE__)}/configuration.yml").inject({}) do |options, (key, value)|
    options[(key.to_sym rescue key) || key] = value
    options
  end
rescue
  {:application_id => 'ValidAppID', :application_key => 'ValidAppKey'}
end

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.include WebMock::API
  config.extend VCR::RSpec::Macros
end

VCR.config do |c|
  c.ignore_localhost = true
  c.cassette_library_dir = 'spec/cassettes'
  c.stub_with :webmock #:typhoeus, :faraday, :fakeweb, or :webmock
  c.default_cassette_options = { :record => :new_episodes }
  c.filter_sensitive_data('ValidAppID') { CONFIGURATION_DEFAULTS[:application_id] }
  c.filter_sensitive_data('ValidAppKey') { CONFIGURATION_DEFAULTS[:application_key] }
end

def configuration_defaults
  CONFIGURATION_DEFAULTS
end

def genability_request_path(path)
  Genability.endpoint + path
end

def a_delete(path)
  a_request(:delete, genability_request_path(path))
end

def a_get(path)
  a_request(:get, genability_request_path(path))
end

def a_post(path)
  a_request(:post, genability_request_path(path))
end

def a_put(path)
  a_request(:put, genability_request_path(path))
end

def stub_delete(path)
  stub_request(:delete, genability_request_path(path))
end

def stub_get(path)
  stub_request(:get, genability_request_path(path))
end

def stub_post(path)
  stub_request(:post, genability_request_path(path))
end

def stub_put(path)
  stub_request(:put, genability_request_path(path))
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

