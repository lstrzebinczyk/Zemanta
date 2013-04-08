require 'spec_helper'

describe Zemanta::Fetcher::Cache::NullResponse do
  it "returns nil by #to_s" do
    Zemanta::Fetcher::Cache::NullResponse.new.to_s.should be_nil
  end
end