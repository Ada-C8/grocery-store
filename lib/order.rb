require 'csv'
require 'pry'

module Grocery
  class Order
    attr_reader :id, :products

    @@all_orders = []

    def initialize(id, products)
      @id = id
      @products = products
      @tax = 0.075
    end

    def self.all
      if @@all_orders.length > 0
        return @@all_orders
      end
      CSV.open("support/orders.csv", "r").each do |line|
        id = line[0].to_i
        products_hash = {}
        products_prices = line[1].split(';')
        products_prices.each do |product|
          ind_product_price = product.split(':')
          products_hash[ind_product_price[0]] = ind_product_price[1].to_f
        end
        @@all_orders << self.new(id, products_hash)
      end
      return @@all_orders
    end

    def self.find(id_input)
      counter = 0
      Order.all.each do |order|
        if order.id == id_input
          counter += 1
          return order
        end
      end
      if counter == 0
        raise ArgumentError.new("Invalid order number - order does not exist")
      end
    end

    def total
      sum = @products.values.inject(0, :+)
      total = sum + (sum * @tax)
      return total.round(2)
    end

    def add_product(product_name, product_price)
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
