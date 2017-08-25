require 'csv'

module Grocery
  class Order
    attr_reader :id, :product_list
    @@list = []

    def initialize(csvrow)
      @id = csvrow[0]
      @product_list = csvrow[1..-1].join("").split(";")
      @@list << {@id => @product_list}
    end

    def self.all
      @@list
    end

    def self.find(id)
      idfound = false
      CSV.read("./support/orders.csv").each do |row|
        if row[0] == id
          Order.new(row[0], row[1..-1])
          idfound = true
        end
      end
      if idfound == false
        return "Order doesn't exist."
      end
    end

    def total
      total = 0
      unless @products.empty?
        @products.each do |product_name, product_price|
          total += (product_price.to_f)
        end
        total += total * (7.50/100)
      end
      total.round(2)
    end

    def add_product(product_name, product_price)
      if @products.has_key?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)
      @products.has_key?(product_name) ? @products.delete(product_name) && true : false
    end
  end

 #new_order = Order.new(1,Slivered Almonds:22.88;Wholewheat flour:1.93;Grape Seed Oil:74.9)


CSV.read("../support/orders.csv").each do |row|
  Order.new(row)
end

puts Order.all
puts Order.find("2")


end


# tryoder = Order.new(123, {"banana" => 3})
# puts tryoder

# all_orders = []
# CSV.open("../support/orders.csv", "r").each do |row|
#   my_order = Order.new(row[0], row[1..-1])
#   all_orders << my_order
# end
