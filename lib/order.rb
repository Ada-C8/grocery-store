require 'csv'
require 'awesome_print'

module Grocery
  class Order
    attr_reader :id, :products, :orders

    def initialize(id, products)
      @id = id
      @products = products
    end #initialize method end


    def self.all
      @orders = []
      CSV.open('/Users/Marisa/documents/ada developers academy/projects/grocery-store/support/orders.csv', 'r').each do |order_attributes|
        order = Grocery::Order.new(
        order_attributes[0].to_i,
        order_attributes[1].split(";").map do |item|
          product_array = item.split(":")
          {name: product_array[0], price: product_array[1].to_f.round(2)}
        end
        )
        @orders << order
      end
      # puts @orders
      ap @orders
    end #self.all method end



    def self.find(id)
      @orders.each do |order|
        if (id == order.id)
          return order
        end
      end
      raise ArgumentError.new("You messed up!")
    end #self.find method end



    def total
      # TODO: implement total
      sum = @products.values.inject(0, :+)
      expected_total = sum + (sum * 0.075).round(2)
      return expected_total
    end #total method end



    def add_product(product_name, product_price)
      # TODO: implement add_product
      # @products[product_name] = product_price
      if @products.include?(product_name)
        return false
      else !@products.include?(product_name)
        @products[product_name] = product_price
        return true
      end
    end #add_product method end


  end #class end
end #module end
