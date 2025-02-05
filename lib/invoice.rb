class Invoice
  def initialize(items:)
    @items = items
    @accumulated_taxes = 0.0
    @final_total = 0.0
  end

  def details
    @details ||= build_receipt
  end

  private

  def build_receipt
    receipt_message = item_details
    receipt_message << "Sales Taxes: #{format('%.2f', @accumulated_taxes)}\n"
    receipt_message << "Total: #{format('%.2f', @final_total)}"
  end

  def item_details
    @items.reduce('') do |output, item|
      update_totals(item)
      output << format_item_details(item)
    end
  end

  def update_totals(item)
    @accumulated_taxes += item.total_taxes
    @final_total += item.total_cost
  end

  def format_item_details(item)
    "#{item.quantity} #{item.description}: #{format('%.2f', item.total_cost)}\n"
  end
end
