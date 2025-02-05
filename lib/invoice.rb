class Invoice
  def initialize(items:)
    @items = items
    @accumulated_taxes = 0.0
    @final_total = 0.0
  end

  private

  def update_totals(item)
    @accumulated_taxes += item.total_taxes
    @final_total += item.total_cost
  end

  def format_item_details(item)
    "#{item.quantity} #{item.description}: #{format('%.2f', item.total_cost)}\n"
  end
end
