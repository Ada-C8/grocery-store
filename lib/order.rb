require 'csv'
require 'awesome_print'
require 'pry'

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
        products_hash = {}
        products_colon = row[1].split(";")
        products_colon.each do |e|
          k = e.split(":").first
          v = e.split(":").last
          products_hash.merge!({k => v.to_f})
        end
        orders_array << Order.new(row[0], products_hash)
      end
      return orders_array
      # puts "This is the orders_array:"
      # ap orders_array
    end

    def self.find(input_id)
      ordered_stuff = {}
      #if id > 1 && id <@orders_array.length
        my_order = Grocery::Order.all
        my_order.each do |order|
          if order.id == input_id
            ordered_stuff = order.products
            return ordered_stuff
          end
        end
        if ordered_stuff.empty?
          raise ArgumentError.new("You did not enter a valid order number.")
        end
    end

    def total
      #Can I add in some code here to convert product value inputs (not brought in from the Csv) into floats, so that it can do math? Maybe a loop here to go through each value and convert it.
      sum = @products.values.inject(0, :+)
      total = sum + (sum * 0.075).round(2)
      return total
    end

    def add_product(product_name, product_price)
      if @products.keys.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)
        @products.delete(product_name)
      return @products
    end
  end # of class

end # end of module

Grocery::Order.all
#print my_order
#ap my_order

#order = Grocery::Order.new(221, {"banana" => 1.99, "cracker" => 3.00 })
#puts order.add_product("sandwich", 4.25)
#puts Grocery::Order[@products]["banana"]
