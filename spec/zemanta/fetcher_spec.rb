require 'spec_helper'

class Zemanta::Fetcher
  private

  def parse(data)
    data
  end
end

class DummyCache
  attr_reader :saved_response

  def initialize(data = nil)
    @data = data
  end

  def fetch
    @data
  end

  def save(response)
    @saved_response = response
  end
end

class DummyWeb
  def fetch
    "web_data"
  end
end


describe Zemanta::Fetcher do
  it "returns the value in cache, if there is one" do
    fetcher = Zemanta::Fetcher.new
    fetcher.stub(:cache).and_return(DummyCache.new("cache_data"))
    fetcher.post.should == "cache_data"
  end

  it "returns the value in web, if there is no cache" do
    cache = DummyCache.new
    fetcher = Zemanta::Fetcher.new
    fetcher.stub(:cache).and_return(cache)
    fetcher.stub(:web).and_return(DummyWeb.new)
    fetcher.post.should == "web_data"
    cache.saved_response.should == "web_data"
  end
end