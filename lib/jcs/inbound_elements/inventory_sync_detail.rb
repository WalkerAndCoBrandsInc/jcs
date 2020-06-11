class JCS::InventorySyncDetail < JCS::InboundBaseElement

  def line_items
    return [] unless hash

    if hash['line_item'].is_a?(Array)
      hash['line_item'].map do |line_item|
        JCS::InventorySyncLineItem.new(line_item)
      end
    else
      [JCS::InventorySyncLineItem.new(hash['line_item'])]
    end
  end

end
