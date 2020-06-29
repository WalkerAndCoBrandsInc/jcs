class Jcs::InboundDetail < Jcs::InboundBaseElement

  def line_items
    if hash['line_item'].is_a?(Array)
      hash['line_item'].map do |line_item|
        Jcs::InboundLineItem.new(line_item)
      end
    else
      [Jcs::InboundLineItem.new(hash['line_item'])]
    end
  end
end
