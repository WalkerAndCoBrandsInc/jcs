class Jcs::ReturnAuthorizationSubmission < Jcs::BaseElement

  DEFAULTS = {
    customer: nil,
    shipment_information: nil,
    credit_card_information: nil,
    return_authorization_order_header: nil,
    detail: nil,
    purchase_order_information: nil,
    customer_id: nil,
    business_name: nil,
    carrier_name: nil,
    return_authorization_id: nil,
  }.freeze

  def defaults
    DEFAULTS
  end

  def initialize(options={})
    super

    @element[:customer] ||= Jcs::Customer.new
    @element[:shipment_information] ||= Jcs::ReturnAuthorizationShipmentInformation.new
    @element[:credit_card_information] ||= Jcs::CreditCardInformation.new
    @element[:return_authorization_order_header] ||= Jcs::ReturnAuthorizationOrderHeader.new
    @element[:purchase_order_information] ||= Jcs::OutboundPurchaseOrderInformation.new
    @element[:detail] ||= Jcs::Detail.new
  end

  def build(builder)
    builder.send('header') do
      builder.send 'customer-id', @element[:customer_id] || Jcs.configuration.customer_id
      builder.send 'business-name', @element[:business_name]
      builder.send 'carrier-name', @element[:carrier_name]
      builder.send('customer-information') do
        @element[:customer].build(builder)
      end
      builder.send('shipment-information') do
        @element[:shipment_information].build(builder)
      end
      builder.send('purchase-order-information') do
        @element[:purchase_order_information].build(builder)
      end
      builder.send('credit-card-information') do
        @element[:credit_card_information].build(builder)
      end
      builder.send('order-header') do
        @element[:return_authorization_order_header].build(builder)
      end
    end
    check_line_items
    builder.send('detail') do
      @element[:detail].build(builder)
    end
  end

  def check_line_items
    if @element[:detail].element[:line_items].empty?
      line_item = Jcs::ReturnAuthorizationLineItem.new
      @element[:detail].element[:line_items] << line_item
    end
  end
end
