require 'spec_helper'

describe JCS do
  it 'has a version number' do
    expect(JCS::VERSION).not_to be nil
  end

  context "configuration" do
    it "has a configuration" do
      expect(JCS.configuration).to be_a JCS::Configuration
    end

    describe ".configure" do
      it "accepts a block" do
        JCS.configure do |config|
          config.api_root = "https://jcs.com/foo"
        end

        expect(JCS.configuration.api_root).to eq "https://jcs.com/foo"
      end

      it 'ensures that the config is valid' do
        expect do
          JCS.configure do |config|
            config.customer_id = nil
          end
        end.to raise_error JCS::Configuration::Error
      end
    end
  end

  describe "#self.domestic_schema?" do
    context "when no international setting is passed in" do
      it "returns true" do
        allow(JCS.configuration).to receive(:international_schema).and_return nil

        expect(JCS.domestic_schema?).to be true
      end
    end
    context "when international is set to true" do
      it "returns false" do
        allow(JCS.configuration).to receive(:international_schema).and_return true

        expect(JCS.domestic_schema?).to be false
      end
    end
    context "when international is set to false" do
      it "returns true" do
        allow(JCS.configuration).to receive(:international_schema).and_return false

        expect(JCS.domestic_schema?).to be true
      end
    end
  end
end
