class Jcs::ShipmentStatus < Jcs::BaseElement

  DEFAULTS = {
    customer_id: nil,
    business_name: nil,
    detail: nil,
    line_items: []
  }.freeze

  def defaults
    DEFAULTS
  end

  def initialize(options={})
    super
    @element[:order_header] ||= Jcs::SalesOrderHeader.new
    check_line_items
    @element[:detail] ||= Jcs::Detail.new({line_items: @element[:line_items]})
  end

  def build(builder)
    builder.send('header') do
      builder.send('customer-information') do
        builder.send 'customer-id', Jcs.configuration.customer_id
        builder.send 'business-name', @element[:business_name]
      end
    end
    builder.send('detail') do
      @element[:detail].build(builder)
    end
  end

  def check_line_items
    if @element[:line_items].empty?
      ss_line_item = Jcs::ShipmentStatusLineItem.new
      @element[:line_items] << ss_line_item
    end
  end
end
