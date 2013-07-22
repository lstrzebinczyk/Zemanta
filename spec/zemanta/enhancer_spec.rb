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

    describe "skip option" do
      it "skips links whose URL matches a user-provided regexp" do
        stub_zemanta_enhancer!
        output = Zemanta::Enhancer.new(input, skip: /machu_picchu/).enhance
        output.scan('<a').should have(1).elements
      end

      it "doesn't affect the links that don't match thr user-provided regexp" do
        stub_zemanta_enhancer!
        output = Zemanta::Enhancer.new(input, skip: /macchu_picchu/).enhance
        output.scan('<a').should have(2).elements
      end
    end

    describe "strip_query_string" do
      it "strips the query string from the suggested urls" do
        text = "Hello foo bar"
        suggestions = [{ word: 'foo', link: "http://bar.com/foo?bar=123" }]
        Zemanta::Enhancer.any_instance.stub(words_to_anchor: suggestions)
        output = Zemanta::Enhancer.new(text, strip_query_string: true).enhance
        output.should == "Hello <a href=http://bar.com/foo>foo</a> bar"
      end
    end
  end
end
