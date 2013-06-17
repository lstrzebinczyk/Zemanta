require 'spec_helper'

describe Zemanta::Markup do
  describe "getter" do
    subject { Zemanta::Markup.new(fixture("markup")) }

    it "for text works well" do
      subject.text.should == "text"
    end

    it "for links returns array of links" do
      subject.links.should be_a Array
      subject.links.first.should be_a Zemanta::Markup::Link
    end

    context ".fetch" do
      it "returns Markup object for nonempty string" do
        stub_zemanta_full!
        Zemanta::Markup.fetch("This is a text").should be_a Zemanta::Markup
      end

      it "returns Markup object for nil" do
        stub_zemanta_full!
        Zemanta::Markup.fetch(nil).should be_a Zemanta::Markup
      end

      it "does not hit fetcher if nil passed" do
        Zemanta::Fetcher.any_instance.should_not_receive(:post)
        Zemanta::Markup.fetch(nil)
      end

      it "returns Markup object for empty string" do
        stub_zemanta_full!
        Zemanta::Markup.fetch("").should be_a Zemanta::Markup
      end

      it "does not hit fetcher if empty string passed" do
        Zemanta::Fetcher.any_instance.should_not_receive(:post)
        Zemanta::Markup.fetch("")
      end
    end
  end
end