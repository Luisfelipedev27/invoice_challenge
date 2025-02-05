require 'spec_helper'
require 'item.rb'
require 'invoice.rb'

RSpec.describe Invoice do
  describe '#details' do
    context 'when there are multiple items' do
      it 'returns the correct invoice details for Input 1' do
        items = [
          Item.new(description: 'book', quantity: 2, unit_price: 12.49),
          Item.new(description: 'music CD', quantity: 1, unit_price: 14.99),
          Item.new(description: 'chocolate bar', quantity: 1, unit_price: 0.85)
        ]
        invoice = Invoice.new(items: items)
        expected_output = "2 book: 24.98\n1 music CD: 16.49\n1 chocolate bar: 0.85\nSales Taxes: 1.50\nTotal: 42.32"
        expect(invoice.details).to eq(expected_output)
      end

      it 'returns the correct invoice details for Input 2' do
        items = [
          Item.new(description: 'imported box of chocolates', quantity: 1, unit_price: 10.00),
          Item.new(description: 'imported bottle of perfume', quantity: 1, unit_price: 47.50)
        ]
        invoice = Invoice.new(items: items)
        expected_output = "1 imported box of chocolates: 10.50\n1 imported bottle of perfume: 54.65\nSales Taxes: 7.65\nTotal: 65.15"
        expect(invoice.details).to eq(expected_output)
      end

      it 'returns the correct invoice details for Input 3' do
        items = [
          Item.new(description: 'imported bottle of perfume', quantity: 1, unit_price: 27.99),
          Item.new(description: 'bottle of perfume', quantity: 1, unit_price: 18.99),
          Item.new(description: 'packet of headache pills', quantity: 1, unit_price: 9.75),
          Item.new(description: 'imported box of chocolates', quantity: 3, unit_price: 11.25)
        ]
        invoice = Invoice.new(items: items)
        expected_output = "1 imported bottle of perfume: 32.19\n" \
                          "1 bottle of perfume: 20.89\n" \
                          "1 packet of headache pills: 9.75\n" \
                          "3 imported box of chocolates: 35.55\n" \
                          "Sales Taxes: 7.90\n" \
                          "Total: 98.38"
        expect(invoice.details).to eq(expected_output)
      end
    end
  end
end
