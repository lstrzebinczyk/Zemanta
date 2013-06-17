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

    it "returns Markup object with fetch" do
      stub_zemanta_full!
      Zemanta::Markup.fetch("This is a text").should be_a Zemanta::Markup
    end
  end
end