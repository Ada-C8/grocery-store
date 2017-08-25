# require 'awesome_print'
# require_relative 'customer'
# require_relative 'online_order'

module Grocery

  require 'csv'

  class Order

    attr_reader :id, :products, :all_orders

    # @@all_orders = []

    def initialize(id, products)
      @id = id.to_i
      @products = products
    end

    def total
      total = 0
      @products.each do |product|
        total += product[1]
      end
      total = (total * 1.075).round(2)
      return total
    end

    def add_product(product_name, product_price)
      unless @products.has_key?(product_name)
        @products[product_name] = product_price
        return true
      else
        return false
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

    # def self.all_orders
    #   return @@all_orders
    # end

    def self.all(filename)
      all_orders = []

      CSV.open(filename).each do |order|
        id = order.shift
        products = []

        order[0].split(';').each do |item|
          product = item.split(':')
          products << {product[0] => product[1].to_f}
        end

        all_orders << self.new(id, products)

      end
      return all_orders
    end

    def self.find(id, orders)
      orders.each do |order|
        if order.id == id
          return order
        end
      end
      # if it didn't find the id:
      raise RangeError.new("ID does not exist")
    end

  end # end of Order class definition


end # end of Grocery module definition
