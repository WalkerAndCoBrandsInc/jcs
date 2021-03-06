class Jcs::MessageHeaderPW < Jcs::BaseElement
  DEFAULTS = {
    message_id:       0,
    transaction_name: nil,
    partner_name:     nil,
    partner_password: nil,
    source_url:       nil,
    create_timestamp: nil,
    response_request: 1
  }.freeze

  format :create_timestamp, Jcs::DateTimeFormatter.new

  def defaults
    DEFAULTS
  end

  def valid?
    if !integer?(@element[:message_id])
      raise Jcs::InvalidType.new('message_id must be a number')
    end

    if !@element[:partner_name]
      raise Jcs::MissingField.new('partner_name must be present')
    end

    true
  end
end
