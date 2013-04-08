require 'spec_helper'

describe Zemanta::Fetcher::Web do
  it "delegates to Typhoeus on #fetch" do
    stub_zemanta_success!
    Zemanta::Fetcher::Web.new.fetch.should == "{\"response\":\"zemanta_response\"}"
  end
end