class JCS::ReturnReceipt < JCS::InboundBaseElement
  def message_id
    @hash["message"]["message_header"]["message_id"]
  end

  def purchase_order_information
    JCS::InboundPurchaseOrderInformation.new(
      @hash["message"]["return_receipt"]["header"]["purchase_order_information"]
    )
  end

  def purchase_order_number
    purchase_order_information.purchase_order_number
  end

  def customer_id
    @hash["message"]["return_receipt"]["header"]["customer_id"]
  end
end
