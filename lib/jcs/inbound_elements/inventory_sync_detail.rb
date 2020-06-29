class Jcs::InventorySyncDetail < Jcs::InboundBaseElement

  def line_items
    return [] unless hash

    if hash['line_item'].is_a?(Array)
      hash['line_item'].map do |line_item|
        Jcs::InventorySyncLineItem.new(line_item)
      end
    else
      [Jcs::InventorySyncLineItem.new(hash['line_item'])]
    end
  end

end
