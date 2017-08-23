require 'csv'

module Grocery
  class Order
    attr_reader :id
    attr_accessor :products

    def initialize(id, products)
      @id = id
      @products = products
      @tax = 0.075
    end

    def self.all
      orders = []
      CSV.open("support/orders.csv", "r").each do |line|
        id = line[0]
        products = line[1]
        orders << self.new(id, products)
      end
      return orders
    end

    def total
      # TODO: implement total
      sum = @products.values.inject(0, :+)
      return sum + (sum * @tax).round(2)
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
      if @products.has_key?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)
      if @products.has_key?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end
  end
end
