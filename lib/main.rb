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
          []
      end
    end

    items
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
    puts 'Available items:'
    puts "-----------------"
    AVAILABLE_ITEMS.each do |item|
      puts "#{item[:description]}"
    end
    puts
    puts 'enter items following the format "|quantity| |item description| at |price|".'
  end
end

Main.new.call
