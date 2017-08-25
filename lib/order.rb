require 'csv'

module Grocery
  class Order
    attr_reader :id, :products

    @@all_orders = []

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      if @products.length == 0
        return 0
      else
        sum = @products.values.inject(0, :+)
        expected_total = sum + (sum * 0.075).round(2)
        return expected_total
      end
    end

    def add_product(product_name, product_price)
      # EVALUATE TO SEE IF PRODUCT NAME IS ALREADY IN THE LIST
      if @products.include?(product_name)
        return false # And do not add to the list and end method
      else
        @products[product_name] = product_price # Add to hash
        if @products.include?(product_name) # Tests if it was added and if it was new
          return true
        end
      end
    end # DEF

    def remove_product(product_name)
      @products.delete(product_name)
      if @products.include?(product_name)
        return false
      end
    end # DEF

    ## CAN I USE A CLASS VARIABLE HERE?
    def self.all
      @@all_orders = []
      CSV.open("support/orders.csv", "r").each do |line|
        items = {}
        line[1].split(";").each do |item_and_price|
          split = item_and_price.split(":")
          items[split[0]] = split[1].to_f.round(2)
        end
        order = Grocery::Order.new(line[0].to_i, items)
        @@all_orders << order
      end
      return @@all_orders # RETURNS ALL ORDERS AT THE TIME ORDERS.ALL
    end

    def self.find(order_num)
      found_order = nil
      CSV.open("support/orders.csv", "r").each do |line|
        if line[0].to_i == order_num
          items = {}
          line[1].split(";").each do |item_and_price|
            split = item_and_price.split(":")
            items[split[0]] = split[1].to_f.round(2)
          end
          order = Grocery::Order.new(line[0].to_i, items)
          found_order = order
          break
        end
      end
      if found_order == nil
        raise ArgumentError.new("Order not found")
      else
        return found_order # RETURNS AN ORDER INSTANCE OF ORDER
      end
    end # DEF
  end # CLASS



end # MODULE
