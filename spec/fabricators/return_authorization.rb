Fabricator(:return_authorization, class_name: JCS::ReturnAuthorization) do
  customer { Fabricate.build(:customer) }
  credit_card_information { Fabricate.build(:credit_card_information) }
  return_authorization_order_header { JCS::ReturnAuthorizationOrderHeader.new(customer_order_number: "RA111") }
  shipment_information { Fabricate.build(:return_authorization_shipment_information) }
  detail { JCS::Detail.new(line_items:[Fabricate.build(:return_authorization_line_item)]) }
end
