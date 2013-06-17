require 'spec_helper'

describe Zemanta do
  it "returns Configuration instance on Zemanta.config" do
    Zemanta.config.should be_a Zemanta::Configuration
  end

  it "passes Configuration instance to block on Zemanta.configure" do
    Zemanta.configure do |config|
      config.should be_a Zemanta::Configuration
    end
  end
end