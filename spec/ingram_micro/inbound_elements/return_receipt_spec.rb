require 'spec_helper'

describe Jcs::ReturnReceipt do
  let(:return_receipt) do
    hash = Nori.new.parse(File.read(Jcs::GEM_DIR + 'spec/input_xmls/return-receipt.xml'))
    Jcs::ReturnReceipt.new(hash)
  end

  it "returns customer_id" do
    expect(return_receipt.customer_id).to eq("565663")
  end
end
