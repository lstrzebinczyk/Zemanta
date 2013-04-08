require 'spec_helper'

describe Zemanta::Markup::Link::Target do
  describe "getter" do
    subject { Zemanta::Markup::Link::Target.new(fixture("target")) }

    it "for url works well" do
      subject.url.should == "www.this.is.an/url"
    end

    it "for type works well" do
      subject.type.should == "geolocation"
    end

    it "for target title works well" do
      subject.title.should == "Tiger Leaping Gorge"
    end
  end
end