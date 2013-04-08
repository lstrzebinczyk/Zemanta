require 'spec_helper'

describe Zemanta::Markup::Link do
  describe "getter" do
    subject { Zemanta::Markup::Link.new(fixture("link")) }

    describe "getter" do
      it "for relevance works well" do
        subject.relevance.should == 0.8093
      end

      it "for confidence works well" do
        subject.confidence.should == 0.873863
      end

      it "for entity title works well" do
        subject.entity_type.should == ["/location/location"]
      end

      it "for target returns array of targets" do
        subject.target.should be_a Array
        subject.target.first.should be_a Zemanta::Markup::Link::Target
      end

      it "for anchor works well" do
        subject.anchor.should == "Tiger Leaping Gorge"
      end
    end

    describe "above?" do
      it "returns true if is above both relevance and confidence" do
        subject.above?(0.5, 0.5).should == true
      end

      it "returns false if relevance is lower" do
        subject.above?(0.9, 0.5).should == false
      end

      it "returns false if confidence is lower" do
        subject.above?(0.5, 0.9).should == false
      end

      it "returns false if both confidence and relevance is lower" do
        subject.above?(0.9, 0.9).should == false
      end
    end
  end
end