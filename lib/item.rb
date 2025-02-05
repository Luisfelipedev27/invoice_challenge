class item
  IMPORT_TAX_RATE = 0.05
  BASE_TAX_RATE = 0.1

  TAX_EXEMPT_CATEGORIES = [
    'book', 'chocolate bar', 'box of chocolates', 'packet of headache pills', 'boxes of chocolates'
  ].freeze

  def initialize(description:, quantity:, unit_price:)
    @description = description
    @quantity = quantity
    @unit_price = unit_price
  end

  def total_cost
    @total_cost = calculate_total_cost
  end

  def total_taxes
    @total_taxes = calculate_total_taxes
  end

  private

  def calculate_total_cost
    (@unit_price * @quantity) + total_taxes
  end

  def calculate_total_taxes
    calculate_rounded_tax * @quantity
  end

  def applicable_tax_rate
    is_imported = imported_item?
    product_name = is_imported ? imported_item?[:name] : @description

    tax_rate = 0
    tax_rate += IMPORT_TAX_RATE if is_imported
    tax_rate += BASE_TAX_RATE unless TAX_EXEMPT_CATEGORIES.include?(product_name)

    tax_rate
  end

  def imported_item?
    /imported\s(?<name>([a-z]+\s*)+)/.match(@description)
  end

  def calculate_rounded_tax
    tax_value = applicable_tax_rate * @unit_price
    rounded_tax = tax_value.ceil(2)
    adjust_rounded_tax(rounded_tax)
  end

  def adjust_rounded_tax(rounded_tax)
    last_digit = format('%.2f', rounded_tax)[-1].to_i
    remainder = last_digit % 5
    (remainder.zero? ? rounded_tax : rounded_tax - (remainder * 0.01) + IMPORT_TAX_RATE).round(2)
  end
end
