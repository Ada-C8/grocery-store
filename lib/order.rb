require 'csv'
require 'awesome_print'

module Grocery
  class Order
    attr_reader :id, :products, :orders

    def initialize(id, products)
      @id = id
      @products = products
      @orders = {}
    end #initialize method end


    def self.all
      @orders = {}
      CSV.open('/Users/Marisa/documents/ada developers academy/projects/grocery-store/support/orders.csv', 'r').each do |id,items|
        @orders[id.to_i] = items.split(";").map do |item|
          array = item.split(":")
          {array[0] => array[1]}
        end
      end
      puts @orders
    end #self.all method end


    # update method to find id and print all the products with it.
    def self.find(id)
      # raised argument error if order ID number is greater than 100.
      if id > 100
        raise ArgumentError.new("You messed up!")
      end
      # looks into all order IDs and returns the ones in the ones .find is called on.
      return @orders[id]

    end #self.find method end


    def total
      # TODO: implement total
      sum = @products.values.inject(0, :+)
      expected_total = sum + (sum * 0.075).round(2)
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

# order_five = Grocery::Order.find(1)
# puts order_five
