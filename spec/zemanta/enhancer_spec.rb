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

    describe "no_duplicates option" do
      it "doesn't use the same link multiple times" do
        stub_zemanta_enhancer!
        input = "I like Machu Pichu. Machu Pichu? Yeah, Machu Pichu"
        output = Zemanta::Enhancer.new(input, no_duplicates: true).enhance
        output.scan('<a').should have(1).elements
      end
    end
  end
end
