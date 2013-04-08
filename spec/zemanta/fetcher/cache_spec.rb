require 'spec_helper'

describe Zemanta::Fetcher::Cache do
  describe "for set storage" do
    before :each do
      Zemanta.configure { |config| config.cache_storage = {} }
      Zemanta::Fetcher::Cache.new("key").save("test data")
    end

    after :all do
      Zemanta.configure { |config| config.cache_storage = Zemanta::Configuration::NullStorage.new }
    end

    it "saves the data to cache if it's saved first time" do
      Zemanta.config.cache_storage.size.should == 1
    end

    it "doesn't save the data if same key was used before" do
      Zemanta::Fetcher::Cache.new("key").save("test data")
      Zemanta.config.cache_storage.size.should == 1
    end

    it "fetch returns nil if no key in cache" do
      Zemanta::Fetcher::Cache.new("another_key").fetch.should be_nil
    end

    it "fetch returns the value data if key is present" do
      Zemanta::Fetcher::Cache.new("key").fetch.should == "test data"
    end
  end
end