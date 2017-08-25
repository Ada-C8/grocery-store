require 'csv'
module Grocery

  ### Don't forget to commit
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      sum = 0
      products.each do |item, price|
        sum = (sum + price)
      end
      return ((sum * 0.075) + sum).round(2)
    end

    def add_product(product_name, product_price)
      if @products.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def self.all
      orders = []
      CSV.open("./support/orders.csv", "r").each do |line|
        products = {}
        id = line[0].to_i

        line[1].split(";").each do |product_info|
          data = product_info.split(":")
          products[data[0]] = data[1].to_f
        end
        orders << Grocery::Order.new(id, products)
      end
      return orders
    end

    def self.find(id)
      found_order = nil
      orders = self.all
      orders.each do |order|
        # puts order.id == id
        # puts order.id.class
        # puts id.class

        if order.id == id
          return found_order = order
        end

      end
      raise ArgumentError.new("Order does not exist")
    end
    # return found_order
  end # end of class
end # module


# order = Grocery::Order.find(101)
# puts order.id




# Grocery::Order.all.each do |order|
# puts order.products
# end

# order = Grocery::Order.all
# puts order[99].id
# puts order[2].products

# new_orders = Grocery::Order.all
# csv = CSV.open("../support/orders.csv", 'r')
# puts csv_product = csv.to_a[0][1].delete(":").delete(";")
# puts order_product = new_orders[0].products.flatten.join
# puts csv_product == order_product
