require 'spec_helper'

describe Zemanta::Fetcher do
  subject { Zemanta::Fetcher.new }

  it "returns the value in cache, if there is one" do
    Zemanta.configure { |config| config.cache_storage = {} }
    stub_zemanta_success!
    subject.post
    subject.post.should == {"response"=>"zemanta_response"}
    Zemanta.configure { |config| config.cache_storage = Zemanta::Configuration::NullStorage.new }
  end

  it "returns the value in web, if there is no cache" do
    stub_zemanta_success!
    subject.post.should == {"response"=>"zemanta_response"}
  end
end
