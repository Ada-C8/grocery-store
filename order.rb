
require 'csv'

module Grocery

  class Order

    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    # Class method that opens the CSV (orders) file to read all orders by row.
    def self.all
      orders = []

      CSV.open("/Users/sesameseed/ADA/grocery-store/support/orders.csv", 'r').each do |line|
        puts line


  # Note that to parse the product string from the CSV file you will need to use the split method


      orders << self.new()
      end
      return orders
    end


    def self.find(id)
      # self.find(id) - returns an instance of Order where the value of the id field in the CSV matches the passed parameter.
    end

# Method to total each order with taxes.
    def total
      expected_total = 0
      products.values.each do |price|
        expected_total = expected_total + price
      end
      expected_total = (expected_total * 1.075).round(2)
      return expected_total
    end
# Method to add products.
    def add_product(product_name, product_price)
      if @products.include?(product_name)
        return false
      else !@products.include?(product_name)
        @products[product_name] = product_price
        return true
      end
    end
  end
end
