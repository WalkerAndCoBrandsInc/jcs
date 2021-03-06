class Jcs::CheckShipmentStatus < Jcs::Transmission
  TRANSMISSION_FILENAME = 'shipment-status'

  attr_accessor :business_name, :customer_id, :line_items

  def initialize(options={})
    super
    @transaction_name = 'shipment-status'
    @business_name = options[:business_name]
    @customer_id = Jcs.configuration.customer_id
    @line_items = options[:line_items]
  end

  def xml_builder
    @builder ||= Nokogiri::XML::Builder.new do |builder|
      builder.message do
        add_message_header(builder)
        add_shipment_status(builder)
        add_transaction_info(builder)
      end
    end
  end

  def add_message_header(builder)
    message_header = Jcs::MessageHeaderNoPW.new({
      partner_name: Jcs.configuration.partner_name,
      transaction_name: transaction_name})
    builder.send('message-header') do
      message_header.build(builder)
    end
    message_header.valid?
  end

  def add_shipment_status(builder)
    options = {
      business_name: @business_name,
      customer_id: @customer_id,
      line_items: @line_items
    }
    ss = Jcs::ShipmentStatus.new(options)
    builder.send('shipment-status') do
      ss.build(builder)
    end
  end
end
