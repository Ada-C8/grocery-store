require 'csv'
module Grocery
  class Order
    attr_reader :id, :products
    
    def initialize(id, products)
      @id = id
      @products = products 
    end
    
    def total #derived from products' attriubute
      sum = products.values.inject(0, :+)
      total = sum + (sum * 0.075).round(2)
      return total
    end
    
    def add_product(product_name, product_price) #behavior on order allowing me to change an attribute of a particular instance of an order
      if @products.has_key?(product_name) #@products is a label/variable that points to a hash
        return false
      else 
        @products[product_name] = product_price
        return true
      end
    end
    def self.all
      orders = []
      CSV.open("./support/orders.csv").each do |id, products|
        order = products.split(/:|;/)
        orders << Grocery::Order.new(id, Hash[*order])
      end
      return orders
    end #self end

    def self.find(id) # returns an instance of Order where 
      all.each do |order|
        return order if order.id == id
      end
      raise ArgumentError.new("Order does not exist")
    end
  end#Order_class end
end #module end




