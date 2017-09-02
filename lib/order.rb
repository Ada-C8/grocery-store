require 'csv'

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    # Wave 2 Starts!
    # Class method that opens the CSV (orders) file to read all orders by row.

    def self.all
      orders = []
      CSV.open("./support/orders.csv", 'r').each do |line|
        id = line[0].to_i
        products = line[1]
        pairs = products.split(";")

        products_hash = {}
        pairs.each do |pair|
          item = pair.split(":")
          products_hash[item[0]] = item[1].to_f
        end

        orders << self.new(id, products_hash)
      end
      return orders
    end

    # Class method that reads the ID of the orders.
    def self.find(id)
      all_orders = self.all
      all_orders.each do |order|
        if order.id == id
          return order
        end
      end
      raise ArgumentError.new("That is not a valid order number, please try again.")
    end

    # Wave 1 starts!
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
# Waves one and two complete, with all tests passing.  Will work on Wave three as I have time for continued practice and would like feedback if possible.
