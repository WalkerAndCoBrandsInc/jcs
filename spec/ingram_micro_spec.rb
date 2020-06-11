require 'spec_helper'

describe Jcs do
  it 'has a version number' do
    expect(Jcs::VERSION).not_to be nil
  end

  context "configuration" do
    it "has a configuration" do
      expect(Jcs.configuration).to be_a Jcs::Configuration
    end

    describe ".configure" do
      it "accepts a block" do
        Jcs.configure do |config|
          config.api_root = "https://jcs.com/foo"
        end

        expect(Jcs.configuration.api_root).to eq "https://jcs.com/foo"
      end

      it 'ensures that the config is valid' do
        expect do
          Jcs.configure do |config|
            config.customer_id = nil
          end
        end.to raise_error Jcs::Configuration::Error
      end
    end
  end

  describe "#self.domestic_schema?" do
    context "when no international setting is passed in" do
      it "returns true" do
        allow(Jcs.configuration).to receive(:international_schema).and_return nil

        expect(Jcs.domestic_schema?).to be true
      end
    end
    context "when international is set to true" do
      it "returns false" do
        allow(Jcs.configuration).to receive(:international_schema).and_return true

        expect(Jcs.domestic_schema?).to be false
      end
    end
    context "when international is set to false" do
      it "returns true" do
        allow(Jcs.configuration).to receive(:international_schema).and_return false

        expect(Jcs.domestic_schema?).to be true
      end
    end
  end
end
