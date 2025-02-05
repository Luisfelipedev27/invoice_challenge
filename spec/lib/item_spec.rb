require 'spec_helper'
require 'item.rb'

RSpec.describe Item do
  describe '#total_cost' do
    context 'when the item is tax exempt' do
      it 'calculates the total cost without base tax' do
        item = Item.new(description: 'book', quantity: 2, unit_price: 12.49)

        expect(item.total_cost).to eq(24.98)
      end
    end

    context 'when the item is not tax exempt' do
      it 'calculates the total cost with base tax' do
        item = Item.new(description: 'music CD', quantity: 1, unit_price: 14.99)

        expect(item.total_cost).to be_within(0.01).of(16.49)
      end
    end

    context 'when the item is imported' do
      it 'calculates the total cost with import tax' do
        item = Item.new(description: 'imported bottle of perfume', quantity: 1, unit_price: 47.50)

        expect(item.total_cost).to be_within(0.01).of(54.65)
      end
    end

    context 'when the item is imported and tax exempt' do
      it 'calculates the total cost with only import tax' do
        item = Item.new(description: 'imported box of chocolates', quantity: 1, unit_price: 10.00)

        expect(item.total_cost).to be_within(0.01).of(10.50)
      end
    end
  end

  describe '#total_taxes' do
    context 'when the item is tax exempt' do
      it 'calculates the total taxes as zero' do
        item = Item.new(description: 'book', quantity: 1, unit_price: 12.49)

        expect(item.total_taxes).to eq(0.00)
      end
    end

    context 'when the item is not tax exempt' do
      it 'calculates the total taxes with base tax' do
        item = Item.new(description: 'music CD', quantity: 1, unit_price: 14.99)

        expect(item.total_taxes).to be_within(0.01).of(1.50)
      end
    end

    context 'when the item is imported' do
      it 'calculates the total taxes with import tax' do
        item = Item.new(description: 'imported bottle of perfume', quantity: 1, unit_price: 47.50)

        expect(item.total_taxes).to be_within(0.01).of(7.15)
      end
    end

    context 'when the item is imported and tax exempt' do
      it 'calculates the total taxes with only import tax' do
        item = Item.new(description: 'imported box of chocolates', quantity: 1, unit_price: 10.00)

        expect(item.total_taxes).to be_within(0.01).of(0.50)
      end
    end
  end
end
