require 'csv'

module Grocery

  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def self.all
      csv_array_of_all_orders = []
      #1: Read the csv file
      CSV.open("support/orders.csv", 'r').each do |line|
        #1A: divide the cvs file into the order number, and the products
        order_id = line[0]
        order_contents = line[1]
        order_contents = order_contents.split(";")
        order_contents.to_s.delete("\,")
        order_contents.to_s.delete(" \" ")
        #1B. Make hashes for all items in order
        #ex. {name1 => cost 1}
        products = Hash.new
        item_index = 0
        order_contents.each do |items|
          current_item = order_contents[item_index]
          item_name = current_item.to_s.split("\:")[0]
          item_cost = current_item.to_s.split("\:")[1].to_f
          item_index = item_index + 1
          products[item_name] = item_cost
        end
        # 1C: make an array with the order id, product hash
        #ex. (order id, ({name1 => cost 1})
        current_order = [order_id, products]
        #1D: make an array of the arrays of order id and product hash
        #ex. ((order_id_1, ({name1 => cost 1}),(order_id_2, ({name2 => cost 2}))
        csv_array_of_all_orders << current_order
      end
      #2. pass the array of arrays of (order id, product hash) into the
      # Order.new command to make an array of Orders
      collection_of_order_objects = []
      csv_array_of_all_orders.each do |order|
        collection_of_order_objects << Order.new(order[0], order[1])
      end
      return collection_of_order_objects
    end

    def self.find(order_id)
      collection_of_orders = Order.all
      collection_of_orders.each do |order|
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
#
