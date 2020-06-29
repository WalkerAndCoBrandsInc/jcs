require 'spec_helper'

describe Jcs::InboundBaseElement do
  it 'is equal to another instance if the input hashes are equal' do
    a = Jcs::InboundBaseElement.new({a: 1})
    b = Jcs::InboundBaseElement.new({a: 1})

    expect(a).to eq b
  end

  it 'is not equal to another instance with a different input hash' do
    a = Jcs::InboundBaseElement.new({a: 1})
    b = Jcs::InboundBaseElement.new({a: 2})

    expect(a).not_to eq b
  end

  it 'is not equal to members of another InboundBaseElement subclass' do
    class Subclass < Jcs::InboundBaseElement; end

    a = Subclass.new({a: 1})
    b = Jcs::InboundBaseElement.new({a: 1})

    expect(a).not_to eq b
  end

  it 'has a transaction_type' do
    element = Jcs::InboundBaseElement.new({
      'message' => {
        'message_header' => {
          'transaction_name' => 'some-transaction-name'
        }
      }
    })

    expect(element.transaction_name).to eq 'some-transaction-name'
  end
end
