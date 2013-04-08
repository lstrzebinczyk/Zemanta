require 'spec_helper'

describe Zemanta::Configuration do
  subject { Zemanta::Configuration.new }
  
  describe "getter" do
    it "gets custom_request_opts" do
      subject.custom_request_opts.should == {}
    end

    it "gets format" do
      subject.format.should == "json"
    end

    it "gets api_key" do
      subject.api_key.should == nil
    end

    it "gets cache_storage" do
      subject.cache_storage.should be_a Zemanta::Configuration::NullStorage
    end
  end

  describe "setter" do
    it "sets custom_request_opts" do
      subject.custom_request_opts = {target_types: "geolocation"}
      subject.custom_request_opts.should == {target_types: "geolocation"}
    end

    it "sets format" do
      subject.format = "xml"
      subject.format.should == "xml"
    end

    it "sets api_key" do
      subject.api_key = "key"
      subject.api_key.should == "key"
    end

    it "sets cache_storage" do
      subject.cache_storage = {}
      subject.cache_storage.should == {}
    end
  end

  it "knows the end_point" do
    subject.end_point.should == "http://api.zemanta.com/services/rest/0.0/"
  end

  it "can build the request_opts" do
    subject.stub(:actual_api_key).and_return("api_key")
    subject.request_opts.should == {
      api_key: "api_key",
      format: "json"
    }
  end

  it "custom_request_opts into request_opts" do
    subject.stub(:actual_api_key).and_return("api_key")
    subject.custom_request_opts = {target_types: "geolocation"}
    subject.request_opts[:target_types].should == "geolocation"
  end
end