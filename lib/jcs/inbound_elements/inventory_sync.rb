class Jcs::InventorySync < Jcs::InboundBaseElement

  def message_header
    @hash['message']['message_header']
  end

  def inventory_status
    @hash['message']['inventory_synchronization']
  end

  def detail
    detail = @hash['message']['inventory_synchronization']['detail']
    Jcs::InventorySyncDetail.new(detail)
  end

end
