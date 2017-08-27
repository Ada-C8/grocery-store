require 'csv'

module Grocery

  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end


    #returns a collection of Order instances, representing all of the Orders described in the CSV. See below for the CSV file specifications
    def self.all
      #csv format = order_id,item1:price1;item2:price2...
      #the number of item and price pairs can vary.
      #Goal = (order id, ({item1 => price1}, {item2 => price2}...))
      csv_array_of_all_orders = []
      #1: Open the csv file and extract order id and all info on products
      CSV.open("support/orders.csv", 'r').each do |line|
        order_id = line[0].to_i
        order_contents = line[1]
        order_contents = order_contents.split(";")
        #2. Parse out the item and price of products.
        #   Store them in a hash.
        products = Hash.new
        item_index = 0
        order_contents.each do |items|
          current_item = order_contents[item_index]
          item = current_item.to_s.split("\:")[0]
          price = current_item.to_s.split("\:")[1].to_f
          item_index = item_index + 1
          products[item] = price
        end
        # 3: Make an array with the order id and product hash
        #ex. (order id, ({name1 => cost 1}, ...))
        current_order = [order_id, products]
        #4: make an array of the arrays of order id and product hash
        #ex. ((order_id_1, ({name1 => cost 1}),(order_id_2, ({name2 => cost 2}))
        csv_array_of_all_orders << current_order
      end
      #5. Make a new instance of Order for each object in the array in 4
      collection_of_order_objects = []
      csv_array_of_all_orders.each do |order|
        collection_of_order_objects << Order.new(order[0], order[1])
      end
      #6. Return an array of all the orders
      return collection_of_order_objects
    end

    #returns an instance of Order where the value of the id field in the CSV matches the passed parameter.
    def self.find(order_id)
      collection_of_orders = Order.all
      collection_of_orders.each do |order|
        if order.id == order_id
          return order
        end
      end
      raise ArgumentError.new("Order number #{order_id} could not be found.")
    end

    #total calculate cost of the order by: 1. summing the products,
    #2. adding a 7.5% tax 3. rounding to two decimal places
    def total
      total = 0
      products.each do |item, cost|
        total += cost + (cost * 0.075)
      end
      return total.round(2)
    end

    # Add_product takes product name and price.  If the item is not
    # already present, it and adds the data to the product collection.
    # Return true if the item is added and false if it is not.
    def add_product(product_name, product_price)
      if @products.key?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end


    # Remove_product takes a product name and removes the product from the # # collection. Return true if the item was successfully removed and false # if not.
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
