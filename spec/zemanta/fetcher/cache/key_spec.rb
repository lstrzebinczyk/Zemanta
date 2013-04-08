require 'spec_helper'

describe Zemanta::Fetcher::Cache::Key do
  it "returns string by #to_s, given string" do
    Zemanta::Fetcher::Cache::Key.new("").to_s.should be_a String
  end

  it "returns string by #to_s, given hash" do
    Zemanta::Fetcher::Cache::Key.new({}).to_s.should be_a String
  end

  it "creates identical values for hashes with different order" do
    key_1 = Zemanta::Fetcher::Cache::Key.new({key: "value", awesomeness: "high"})
    key_2 = Zemanta::Fetcher::Cache::Key.new({awesomeness: "high", key: "value"})
    key_1.to_s.should == key_2.to_s
  end
end