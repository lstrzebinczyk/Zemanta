require 'spec_helper'

describe "suggest_markup" do
  before(:each) do
    stub_zemanta_full!
  end

  let(:markup) { Zemanta::Markup.fetch("some text") }
  
  it "responds to #text" do
    markup.text.should == "text"
  end

  it "responds to #links" do
    markup.links.should be_a Array
  end

  describe ".links.first" do
    let(:link) { markup.links.first }

    it "responds to #relevance" do
      link.relevance.should == 0.8093
    end

    it "responds to #confidence" do
      link.confidence.should == 0.873863
    end

    it "responds to #entity_type" do
      link.entity_type.should == ["/location/location"]
    end

    it "responds to #target" do
      link.target.should be_a Array
    end

    it "responds to #anchor" do
      link.anchor.should == "Tiger Leaping Gorge"
    end

    describe ".target.first" do
      let(:target) { link.target.first }

      it "answers to #url" do
        target.url.should == "www.this.is.an/url"
      end

      it "answers to #type" do
        target.type.should == "geolocation"
      end

      it "answers to #title" do
        target.title.should == "Tiger Leaping Gorge"
      end
    end
  end
end