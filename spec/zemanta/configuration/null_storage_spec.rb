require 'spec_helper'

describe Zemanta::Fetcher::Web do
  subject { Zemanta::Configuration::NullStorage.new }

  it "returns nil on #[]" do
    subject[:key].should be_nil
  end

  it "responds to #save" do
    subject.should respond_to :[]=
  end
end