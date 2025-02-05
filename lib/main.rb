require_relative 'item'
require_relative 'invoice'

class Main
  AVAILABLE_ITEMS = [
    { description: 'book', price: 12.49 },
    { description: 'music CD', price: 14.99 },
    { description: 'chocolate bar', price: 0.85 },
    { description: 'imported box of chocolates', price: 10.00 },
    { description: 'imported bottle of perfume', price: 47.50 }
  ].freeze

  attr_accessor :error_messages

  def initialize
    self.error_messages = []
  end

  def call
    welcome_message
    items = fetch_item_input
    invoice = Invoice.new(items: items)
    display_results(invoice)
  end

  private

  def welcome_message
    puts 'Welcome to Market! Please enter items following the format "|quantity| |item description| at |price|".'
    puts 'If you need help, type "help".'
  end

  def fetch_item_input
    items = []

    loop do
      input = gets.chomp
      case input.downcase
        when 'ok'
          break
        when 'help'
          help_commands
        when 'list'
          list_available_items
        else
          item_data = parse_item_input(input)
          if item_data.nil?
            log_error(input)
          else
            items << create_item(item_data)
            puts 'Item added!'
            puts 'type "ok" to complete your market or type "quit" to exit'
            puts "---------------------------------------------------------"
          end
        end
      end

    items
  end

  def parse_item_input(input)
    /(?<quantity>\d+)\s(?<description>([a-zA-Z]+\s*)+)\sat\s(?<price>(\d+\.\d{2}))/.match(input)
  end

  def log_error(input)
    error_messages << "Item: '#{input}' could not be processed\n"
  end

  def create_item(item_data)
    Item.new(
      description: item_data[:description],
      quantity: item_data[:quantity].to_i,
      unit_price: item_data[:price].to_f
    )
  end

  def display_results(invoice)
    puts error_messages
    puts 'Your Invoice:'
    puts invoice.details
  end

  def help_commands
    puts <<~HELP
      Available commands:
        finish: Complete the item entry
        quit: Quit the program
        help: Display this message
        list: List all available items
    HELP
  end

  def list_available_items
    puts 'Available items: (Some products are subject to Taxes)'
    puts "-----------------"
    AVAILABLE_ITEMS.each do |item|
      puts "#{item[:description]}: $#{'%.2f' % item[:price]}"
    end
    puts
    puts 'enter items following the format "|quantity| |item description| at |price|".'
  end
end

Main.new.call
