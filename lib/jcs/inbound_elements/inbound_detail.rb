class JCS::InboundDetail < JCS::InboundBaseElement

  def line_items
    if hash['line_item'].is_a?(Array)
      hash['line_item'].map do |line_item|
        JCS::InboundLineItem.new(line_item)
      end
    else
      [JCS::InboundLineItem.new(hash['line_item'])]
    end
  end
end
