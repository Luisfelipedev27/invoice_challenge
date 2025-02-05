class item
  IMPORT_TAX_RATE = 0.05
  BASE_TAX_RATE = 0.1

  TAX_EXEMPT_CATEGORIES = [
    'book', 'chocolate bar', 'box of chocolates', 'packet of headache pills', 'boxes of chocolates'
  ].freeze

  def initialize()
  end

  def total_cost
  end

  def total_taxes
  end

  private
end
