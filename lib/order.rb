require 'csv'

module Grocery

  class Grocery_Records
    attr_reader

    def initialize
      @file_name = ""
    end

    def read_csv(file_name)
      array_of_all_orders =[]
      CSV.open(file_name, 'r').each do |line|
        #divide the cvs file into the order number, and the products
        order_id = line[0]
        order_contents = line[1]
        order_contents = order_contents.split(";")
        order_contents.to_s.delete("\,")
        order_contents.to_s.delete(" \" ")


        products = Hash.new
        item_index = 0
        order_contents.each do |items|
          current_item = order_contents[item_index]
          item_name = current_item.to_s.split("\:")[0]
          item_cost = current_item.to_s.split("\:")[1].to_f
          item_index = item_index + 1


          #make a hashes for all items in order
          #ex. ({name1 => cost 1}, {name2 => cost 2})
          products[item_name] = item_cost
          products
        end
        # make an array with the order id and the products
        #ex. (order id, ({name1 => cost 1}, {name2 => cost 2}))
        current_order = [order_id, products]
        #make an array of all the orders
        array_of_all_orders << current_order
      end
      array_of_all_orders
    end

  end #end of class


  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def self.all
      collection_of_orders=[]
      new_database = Grocery_Records.new
      records= new_database.read_csv("support/orders.csv")
      records.each do |order|
        collection_of_orders << Order.new(order[0], order[1])
      end
      return collection_of_orders
    end

    def self.find(order_id)
      collection_of_orders = Order.all
      collection_of_orders.length
      collection_of_orders.each do |order|
        order.id
        if order.id == order_id.to_s
          return order
        end
      end
      raise ArgumentError.new("Order number #{order_id} could not be found.")
    end


    def total
      total = 0
      products.each do |name, price|
        total += price + (price * 0.075)
      end
      return total.round(2)
    end

    def add_product(product_name, product_price)
      if @products.key?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)
      if @products.key?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

  end #end  class Order
end #end module Grocery
