require 'csv'
# require_relative 'online_order'

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      sum = 0
      products.each do |item, price|
        sum = (sum + price)
      end
      return ((sum * 0.075) + sum).round(2)
    end

    def add_product(product_name, product_price)
      if @products.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def self.all
      orders = []
      CSV.open("./support/orders.csv", "r").each do |line|
        products = {}
        id = line[0].to_i

        line[1].split(";").each do |product_info|
          data = product_info.split(":")
          products[data[0]] = data[1].to_f
        end
        orders << Grocery::Order.new(id, products)
      end
      return orders
    end

    def self.find(id)
      found_order = nil
      orders = self.all
      orders.each do |order|
        if order.id == id
          return found_order = order
        end
      end
      raise ArgumentError.new("Order does not exist")
    end
  end # end of class
end # module
