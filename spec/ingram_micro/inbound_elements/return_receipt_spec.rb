require 'spec_helper'

describe JCS::ReturnReceipt do
  let(:return_receipt) do
    hash = Nori.new.parse(File.read(JCS::GEM_DIR + 'spec/input_xmls/return-receipt.xml'))
    JCS::ReturnReceipt.new(hash)
  end

  it "returns customer_id" do
    expect(return_receipt.customer_id).to eq("565663")
  end
end
