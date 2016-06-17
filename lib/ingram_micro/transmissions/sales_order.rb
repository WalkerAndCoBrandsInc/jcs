class IngramMicro::SalesOrder < IngramMicro::Transmission
  attr_reader :customer, :credit_card_information, :order_header,
  :shipment_information, :detail

  def initialize(options={})
    super(options)
    @transaction_name = 'sales-order-submission'
    @customer = options[:customer]
    @shipment_information = options[:shipment_information]
    @credit_card_information = options[:credit_card_information]
    @order_header = options[:order_header]
    @detail = options[:detail]
    @business_name = options[:business_name]
    @customer_id = options[:customer_id]
    @carrier_name = options[:carrier_name]
  end

  def order_builder
    @builder ||= Nokogiri::XML::Builder.new do |builder|
      builder.message do
        add_message_header(builder)
        add_sales_order_submission(builder)
        add_transaction_info(builder)
      end
    end
  end

  def add_message_header(builder)
    message_header = IngramMicro::MessageHeaderPW.new({
      partner_name: IngramMicro.configuration.partner_name,
      transaction_name: transaction_name})
    builder.send('message-header') do
      message_header.build(builder)
    end
    message_header.valid?
  end

  def add_sales_order_submission(builder)
    sos_options = {
      detail: detail,
      business_name: @business_name,
      customer_id: @customer_id,
      carrier_name: @carrier_name,
      customer: customer,
      shipment_information: shipment_information,
      order_header: order_header,
      credit_card_information: credit_card_information
    }
    sos = IngramMicro::SalesOrderSubmission.new(sos_options)
    builder.send('sales-order-submission') do
      sos.build(builder)
    end
  end
end