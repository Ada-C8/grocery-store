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
        id = line[0].to_i
        products_hash = {}
        products_prices = line[1].split(';')
        products_prices.each do |product|
          ind_product_price = product.split(':')
          products_hash[ind_product_price[0]] = ind_product_price[1].to_f
        end
        orders << self.new(id, products_hash)
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
