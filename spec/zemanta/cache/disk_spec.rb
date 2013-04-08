require 'spec_helper'

describe Zemanta::Cache::Disk do
  let(:cache) { Zemanta::Cache::Disk }
  let(:storage) { cache.new }

  describe "#initialize" do
    it "creates directory to store files if one doesnt exist" do
      temp_dir = Pathname.new('spec/temp_dir')
      temp_dir.delete if temp_dir.exist?
      temp_dir.should_not exist

      cache.new(temp_dir)
      temp_dir.should exist
      temp_dir.delete
    end

    it "uses tmp/db as default directory" do
      storage.db.should == Pathname.new('tmp/db')
    end
  end

  describe "#[key]" do
    it "returns nil if key doesnt exist" do
      storage['non-existing-key'].should be_nil
    end

    it "returns stored value if the key exists" do
      value = "string data"
      storage['key'] = value
      storage['key'].should == value
    end
  end

  describe "#[key]=" do
    let(:key)   { 'some-key' }
    let(:value) { 'text-value' }

    it "creates new file for specified key" do
      Pathname.new(storage.db.join(key)).delete
      Pathname.new(storage.db.join(key)).should_not exist

      storage[key] = value
      Pathname.new(storage.db.join(key)).should exist
    end

    it "overwrites existing file for specified key" do
      storage[key] = value
      storage[key] = "new value"
      storage[key].should == "new value"
    end
  end
end
