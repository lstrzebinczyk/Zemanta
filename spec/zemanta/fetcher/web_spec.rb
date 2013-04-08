require 'spec_helper'

class DummyResponse
  def response_body
    "String of data"
  end
end

describe Zemanta::Fetcher::Web do
  it "delegates to Typhoeus on #fetch" do
    Typhoeus.should_receive(:post).and_return(DummyResponse.new)
    Zemanta::Fetcher::Web.new.fetch.should == "String of data"
  end
end