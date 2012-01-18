require File.expand_path('../../spec_helper', __FILE__)

describe Genability::Client do

  Genability::Configuration::VALID_FORMATS.each do |format|

    context ".new(:format => '#{format}')" do

      use_vcr_cassette "accounts"

      before(:all) do


      end



    end
  end
end

