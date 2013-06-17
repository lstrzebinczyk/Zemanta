
require 'spec_helper'

describe "incorrect api key" do
  let(:markup) { Zemanta::Markup.fetch("some text") }

  it "raises exception when 403 error returned" do
    stub_zemanta_exception!
    expect { markup }.to raise_error("Zemanta returned '<h1>403 Developer Inactive</h1>' exception. Quite possibly you passed incorrect api_key.")
  end
end