Fabricator(:return_authorization, class_name: Jcs::ReturnAuthorization) do
  customer { Fabricate.build(:customer) }
  credit_card_information { Fabricate.build(:credit_card_information) }
  return_authorization_order_header { Jcs::ReturnAuthorizationOrderHeader.new(customer_order_number: "RA111") }
  shipment_information { Fabricate.build(:return_authorization_shipment_information) }
  detail { Jcs::Detail.new(line_items:[Fabricate.build(:return_authorization_line_item)]) }
end
