require 'csv'
require 'pry'

module Grocery
  class Order
    attr_reader :id
    attr_accessor :products

    # @@all_orders

    def initialize(id, products)
      @id = id
      @products = products
      @tax = 0.075
    end

    #if @@all_orders is a hash then find.all you can search the has for the key = order idea

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

    # unless LEGAL_SUITS.include? suit
    #   raise ArgumentError.new("Invalid suit: #{suit}")
    # end

    #find a way to do a class variable
    def self.find(id_input)
      orders = Order.all
      counter = 0
      orders.each do |order|
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
