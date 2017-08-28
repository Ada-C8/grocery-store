require 'csv'
require 'ap'

# og code using hash products
module Grocery
  class Order
    attr_reader :id, :products

    # @@orders = []

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      # TODO: implement total
      total = 0
      subtotal = @products.values.inject(0, :+)
      total = (subtotal * 1.075).round(2)
      return total
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
      if @products.keys.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)
      if @products.keys.include?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

    def self.all
      orders = []
      # if @@orders.length > 0
      #   return @@orders
      # end
      CSV.open("support/orders.csv", 'r').each do |line|
        id = line[0].to_i
        # line[1] = line[1].split(';')
        # line[1] = line[1].gsub!':' '=>'
        # products = line[1].to_h
        # products = line[1]
        products_hash = {}
        products_arr = line[1].split';'
        products_arr.each do |item_colon_price|
          product_price = item_colon_price.split':'
          products_hash[product_price[0]] = product_price[1].to_f

        end

        orders << self.new(id, products_hash)

      end
      return orders
    end

    def self.find(id_input)
      counter = 0
      self.all.each do |order|
        if order.id == id_input
          counter += 1
          return order
        end
      end
      if counter == 0
        raise ArgumentError.new("Invalid Customer ID")
      end
    end
  end
end


# ap Grocery::Order.all
# ap Grocery::Order.find(4)
# ap Grocery::Order.find(4).products
