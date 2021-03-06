require 'spec_helper'

describe Jcs::OutboundShipmentInformation do
  let(:empty_shipment_info) { Jcs::OutboundShipmentInformation.new }
  let(:shipment_info) { Fabricate.build(:shipment_information)}
  let(:ship_info_bad_shipping_method) { Jcs::OutboundShipmentInformation.new({ship_via: 'ABCD'})}

  describe '#initialize' do
    context 'without values passed in' do
      it 'creates a ShipmentInformation object with a hash' do
        expect(empty_shipment_info.element).to be_a(Hash)
      end

      it 'has attributes set to default values' do
        expect(empty_shipment_info.element[:ship_first_name]).to be nil
        expect(empty_shipment_info.element[:ship_city]).to be nil
        expect(empty_shipment_info.element[:ship_via]).to be nil
      end
    end

    context 'with data provided at initialization' do
      it 'creates a ShipmentInformation object' do
        expect(shipment_info).to be_truthy
      end

      it 'has attributes set to specified values' do
        expect(shipment_info.element[:ship_first_name]).to be_a(String)
        expect(shipment_info.element[:ship_city]).to be_a(String)
        expect(shipment_info.element[:ship_via]).to be_a(String)
      end
    end
  end

  describe '#valid_shipping_methods?' do
    context 'without values passed in' do
      it 'returns false for a nil SHIPPING_METHODS' do
        expect(empty_shipment_info.valid_shipping_methods?).to be false
      end
    end
    context 'with a valid shipping code entered' do
      it 'returns true' do
        expect(shipment_info.valid_shipping_methods?).to be true
      end
    end
    context 'with an invalid shipping code entered' do
      it 'returns false' do
        expect(ship_info_bad_shipping_method.valid_shipping_methods?).to be false
      end
    end
  end

  describe '#strip_ship_address2' do
    it 'strips empty ship_address2' do
      shipment_info.strip_ship_address2
      expect(shipment_info.element[:ship_address2]).to be_nil
    end
  end

  describe '#shipping_method_name' do
    context 'with no shipping_method value passed in' do
      it 'returns invalid shipping_method message' do
        expect(empty_shipment_info.shipping_method_name).to eq('Invalid shipping code')
      end
    end

    context 'with invalid shipping_method value passed in' do
      it 'returns invalid shipping_method message' do
        expect(ship_info_bad_shipping_method.shipping_method_name).to eq('Invalid shipping code')
      end
    end

    context 'with valid shipping_method value passed in' do
      it 'should return the shipping method associated with the code' do
        expect(Jcs::SHIPPING_METHODS.values).to include(shipment_info.shipping_method_name)
      end
    end
  end

  it 'formats first name' do
    Nokogiri::XML::Builder.new do |builder|
      builder.send('message') do
        Jcs::OutboundShipmentInformation.new({ship_first_name: 'Jeffrey'}).build(builder)
      end

      expect(builder.to_xml).to include('<ship-first-name>Jeffrey</ship-first-name>')
    end
  end

  it 'strips empty spaces from address2' do
    Nokogiri::XML::Builder.new do |builder|
      builder.send('message') do
        Jcs::OutboundShipmentInformation.new({ship_address2: ' '}).build(builder)
      end

      expect(builder.to_xml).to include('<ship-address2/>')
    end
  end
end
