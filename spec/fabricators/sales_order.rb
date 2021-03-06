Fabricator(:sales_order, class_name: Jcs::SalesOrder) do
  carrier_name { Jcs::SHIPPING_METHODS.values.sample }
  business_name { Faker::Company.name }
  customer_id { (0..100).to_a.sample }
  customer { Fabricate.build(:customer) }
  credit_card_information { Fabricate.build(:credit_card_information) }
  sales_order_header { Fabricate.build(:sales_order_header)}
  sales_order_shipment_information { Fabricate.build(:sales_order_shipment_information) }
  detail { Jcs::Detail.new(line_items: [Fabricate.build(:sales_order_line_item)])}
end
