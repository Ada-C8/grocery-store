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


        products = []
        item_index = 0
        order_contents.each do |items|
          current_item = order_contents[item_index]
          item_name = current_item.to_s.split("\:")[0]
          item_cost = current_item.to_s.split("\:")[1].to_f
          item_index = item_index + 1

          #make a hash for one product (item_name => item_cost)
          current_item = Hash.new
          current_item = {
            item_name => item_cost
          }
          #make an array of hashes for all items in order
          #ex. ({name1 => cost 1}, {name2 => cost 2})
          products << current_item
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

    def total
      total = 0
      products.each do |name, price|
        total += price + (price * 0.075)
      end
      return total.round(2)
    end

    # def update_database(file_name)
    #   new_database = Grocery_Records.new
    #   new_database.read_csv(file_name)
    #
    #   new_database.each do |order|
    #     Order
    # end



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
t = Grocery::Order.new(1, {"Slivered Almonds"=>22.88, "Wholewheat flour"=>1.93, "Grape Seed Oil"=>74.9})

puts t.total

# inventory = {
#   "apple" => 1.0,
#   "tomato_soup" => 2.0,
#   "milk" => 2.50,
#   "chicken" => 5.75
# }
#
# t = Grocery::Order.new(1, inventory)
# puts t.remove_product("apple")
