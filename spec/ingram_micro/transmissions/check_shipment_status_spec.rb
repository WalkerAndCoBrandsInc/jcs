require 'spec_helper'

describe Jcs::CheckShipmentStatus do

  let(:empty_shipment_status) { Jcs::CheckShipmentStatus.new }

  let(:options) {{

  }}
  let(:shipment_status_with_info) { Fabricate.build(:check_shipment_status) }


  describe 'schema_valid?' do
    context 'shipment status with information' do
      it 'creates a valid xml form' do
        expect(shipment_status_with_info.schema_valid?).to be true
      end
    end
  end

  describe 'xml_builder' do
    context 'shipment status with information' do
      it 'generates xml' do
        expect(shipment_status_with_info.xml_builder.to_xml).to have_xml('/message/message-header/transaction-name', 'shipment-status')
      end
    end
  end
end
