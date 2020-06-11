require 'spec_helper'

describe JCS::Transmission do
  let(:sales_order) { Fabricate.build(:sales_order) }

  it 'should raise exception if xml does not match schema' do
    builder = Nokogiri::XML::Builder.new
    expect(sales_order).to receive(:xml_builder).and_return(builder)

    expect {
      sales_order.submit_request
    }.to raise_error(JCS::XMLSchemaMismatch)
  end

  it 'should submit request if xml matches schema' do
    expect(sales_order).to receive(:send_request)
    expect { sales_order.submit_request }.not_to raise_error
  end
end
