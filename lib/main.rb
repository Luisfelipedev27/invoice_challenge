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
  end

  private

  def welcome_message
    puts 'Welcome to Market! Please enter items following the format "|quantity| |item description| at |price|".'
    puts 'If you need help, type "help".'
  end
end
