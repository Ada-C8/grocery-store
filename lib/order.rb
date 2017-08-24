require 'csv'
require 'awesome_print'

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    #imports orders in from CSV
    def self.all
      orders_array = []
      CSV.read('./support/orders.csv').each do |row|
        products_array = []
        #or I can use an empty hash like products_hash = {}
        products_colon = row[1].split(";")
        products_colon.each do |e|
          k = e.split(":").first
          v = e.split(":").last
          products_array << {k => v}
          #products_hash.merge({k => v})
        end
        orders_array << Order.new(row[0], products_array) # this wouldbe products_hash as second argument
      end
      return orders_array
    end

    def self.find(id)
      #if id > 1 && id <@orders_array.length
        Orders.all.each do |order|
          if order.id == id
            return order
          end
        end
        return nil
    end

    def total
      # TO DO: implement total
      sum = products.values.inject(0, :+)
      total = sum + (sum * 0.075).round(2)
      return total
    end

    def add_product(product_name, product_price)
      # TO DO: implement add_product
      if @products.keys.include?(product_name)
        return false
      else @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)
      #@products.delete_if {|key, value| key >= product_name}
      @products.delete(product_name)
      return @products
    end
  end # of class
end # end of module

#print Grocery::Order.all

# orders_array = [1 => [{Slivered Almonds => 22.88}, {Wholewheat flour => 1.93}, {Grape Seed Oil => 74.9}], 2 => [{Albacore Tuna => 36.92}, {Capers => 97.99}, {Sultanas => 2.82}, {Koshihikari rice => 7.55}]

#order = Grocery::Order.new(221, {"banana" => 1.99, "cracker" => 3.00 })
#puts order.add_product("sandwich", 4.25)
#puts Grocery::Order[@products]["banana"]
