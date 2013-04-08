require 'spec_helper'

describe Zemanta do
  it "makes request with text and method params on #suggest_markup" do
    context = Zemanta.new("This is a text")
    context.stub(:suggest_markup_request) { fixture("markup") }
    context.suggest_markup.should be_a Zemanta::Markup
  end

  it "returns Configuration instance on Zemanta.config" do
    Zemanta.config.should be_a Zemanta::Configuration
  end

  it "passes Configuration instance to block on Zemanta.configure" do
    Zemanta.configure do |config|
      config.should be_a Zemanta::Configuration
    end
  end
end
