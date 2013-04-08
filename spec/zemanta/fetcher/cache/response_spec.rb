require 'spec_helper'

describe Zemanta::Fetcher::Cache::Response do
  it "returns saved data by #to_s" do
    response = Zemanta::Fetcher::Cache::Response.new("String of data")
    response.to_s.should == "String of data"
  end
end