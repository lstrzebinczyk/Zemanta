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
      before(:each) { stub_zemanta_enhancer! }

      it "returns Markup object for nonempty string" do
        Zemanta::Markup.fetch("This is a text").should be_a Zemanta::Markup
      end

      it "returns Markup object for nil" do
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

      it "truncated text that is over the characted limit" do
        Zemanta.config.character_limit = 10
        text = 'Text over 10 characters'
        Zemanta::Fetcher.should_receive(:new).with(hash_including(text: text[0..9])).and_call_original
        Zemanta::Markup.fetch(text)
      end

      it "does not hit fetcher if empty string passed" do
        Zemanta::Fetcher.any_instance.should_not_receive(:post)
        Zemanta::Markup.fetch("")
      end

      it "calls drop_links_below on created markup" do
        Zemanta::Markup.any_instance.should_receive(:drop_links_below)
        Zemanta::Markup.fetch("This is a text")
      end

      it "returns every link if no relevance or confidence passed" do
        Zemanta::Markup.fetch("This is a text").links.count.should == 2
      end

    end

    context "drop_links_below" do
      subject { Zemanta::Markup.new(fixture("enhancer")['markup'])}

      it "drops links below given relevance" do
        subject.drop_links_below(0.9, 0)
        subject.links.map(&:relevance).should == [0.91956]
      end

      it "drops links below given confidence" do
        subject.drop_links_below(0, 0.85)
        subject.links.map(&:confidence).should == [0.878267]
      end

      it "drops links below both given condifence and relevance" do
        subject.drop_links_below(0.9, 0.9)
        subject.links.empty?.should == true
      end
    end
  end
end
