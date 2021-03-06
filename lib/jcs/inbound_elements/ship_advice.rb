class Jcs::ShipAdvice < Jcs::InboundBaseElement

  def customer_id
    @hash['message']['ship_advice']['header']['customer_id']
  end

  def shipment_information
    shipment_information_hash = @hash['message']['ship_advice']['header']['shipment_information']
    Jcs::InboundShipmentInformation.new(shipment_information_hash)
  end

  def purchase_order_information
    purchase_order_information_hash = @hash['message']['ship_advice']['header']['purchase_order_information']
    Jcs::InboundPurchaseOrderInformation.new(purchase_order_information_hash)
  end

  def order_header
    order_header_hash = @hash['message']['ship_advice']['header']['order_header']
    Jcs::InboundOrderHeader.new(order_header_hash)
  end

  def detail
    detail_hash = @hash['message']['ship_advice']['detail']
    Jcs::InboundDetail.new(detail_hash)
  end
end
