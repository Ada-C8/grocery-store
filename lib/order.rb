require 'csv'

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def self.all
      @all_orders = []
      CSV.read("support/orders.csv").each do |row|
        order = self.order_from_row(row)
        @all_orders << order
      end
      return @all_orders
    end



    def total
      total = 0

      products.each do |item, cost|
        total += cost
      end
      return total + (total * 0.075).round(2)
    end

    def add_product(product_name, product_price)

      if @products.has_key?(product_name)
        return false
      end

      products[product_name] = product_price

      if @products.include?(product_name)
        return true
      end
    end

    private

    def self.order_from_row(row)
      id = row[0].to_i
      products = self.parse_product_string(row[1])
      Order.new(id, products)
    end

    def self.parse_product_string(product_string)
      pair_strings = product_string.split(';')
      pairs = []
      pair_strings.each do |pair|
        pairs << pair.split(':')
      end
      products = {}
      pairs.to_h.each do |item, cost|
        products[item] = cost.to_f
      end
      return products
    end

  end #end of class

end #end of module
