module Grocery
  class Order
    attr_reader :id, :products, :all_orders

    def initialize(id, products)#products is a hash with item => price
      @id = id.to_i
      @products = products
      @total = 0
      @all_orders = [products]
    end #initialize

    def total
      pretax = 0
      @products.each_value do |value|
        pretax += value
      end #each item calculation
      @total = pretax + (0.075 * pretax).round(2)
      return  @total
    end #total method

    def add_product(product_name, product_price)
      if @products.keys.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true #@products
      end
    end #add_product method

    def remove_product(product_name)
      if @products.keys.include?(product_name)
        @products.delete(product_name)
      else
        return "#{product_name} not found."
      end #if include

      if @products.keys.include?(product_name)
        return false
      else
        return true
      end
    end #remove_product method

    def show_order
      list = ""
      @products.each do |product_name, product_price|
        list += "#{product_name}: #{product_price}\n"

      end #each end
      return list
    end #show order method end
  end #class end
end #module



# id = 1337
# order = Grocery::Order.new(id, {})
#
# order.add_product("apples", 2.00)
# order.add_product("cake", 2.50)
# order.add_product("crackers", 2.50)
# order.add_product("crackers", 2.50)
#
# puts order.inspect
# puts order.show_order
#
# order.remove_product("crackers")
# order.remove_product("crackers")
#
#
# puts order.inspect
