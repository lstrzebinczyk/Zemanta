require 'spec_helper'

describe Zemanta::Enhancer do
  context "enhance" do
    let(:input) { "Here be dragons: Inca trail to Machu Picchu, Machu Pichu" }

    it "returns string" do
      stub_zemanta_enhancer!
      Zemanta::Enhancer.new(input).enhance.should be_a String
    end

    it "converts keywords to links" do
      stub_zemanta_enhancer!
      Zemanta::Enhancer.new(input).enhance.scan('<a').should have(2).elements
    end
  end
end