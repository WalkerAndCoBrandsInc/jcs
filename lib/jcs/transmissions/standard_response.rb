class Jcs::StandardResponse < Jcs::Transmission
  TRANSMISSION_FILENAME = 'standard-response'

  attr_accessor :status_code, :status_description, :comments,
    :response_timestamp, :filename, :transaction_name

  def initialize(options={})
    super(options)
    @transaction_name = options[:transaction_name]
    @status_code = options[:status_code]
    @status_description = options[:status_description]
    @comments = options[:comments]
    @response_timestamp = options[:response_timestamp]
    @filename = options[:filename]
  end

  def to_xml(opts={})
    xml_builder.to_xml
  end

  def xml_builder
    @builder ||= Nokogiri::XML::Builder.new do |builder|
      builder.message do
        add_message_header(builder)
        add_message_status(builder)
        add_transaction_info(builder)
      end
    end
  end

  def add_message_header(builder)
    message_header = Jcs::MessageHeaderPW.new({
      partner_name: Jcs.configuration.partner_name,
      transaction_name: transaction_name})
    builder.send('message-header') do
      message_header.build(builder)
    end
    message_header.valid?
  end

  def add_message_status(builder)
    message_status = Jcs::MessageStatus.new({
      status_code: @status_code,
      status_description: @status_description,
      comments: @comments,
      response_timestamp: @response_timestamp,
      filename: @filename
    })
    builder.send('message-status') do
      message_status.build(builder)
    end
  end
end
