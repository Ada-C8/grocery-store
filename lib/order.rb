require 'csv'

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = {}

      if products.length > 0
        products.each {|product, value| @products[product] = value}
      end

    end

    def total
      sum = 0
      products.each_value do |value|
        sum = sum + value
      end
      expected_total = sum + (sum * 0.075).round(2)
      return expected_total
    end

    def add_product(product_name, product_price)
      unless @products.has_key?(product_name)
        @products[product_name] = product_price
        return true
      else
        return false
      end
    end

    def remove_product(product_name)
      if @products.has_key?(product_name)
        @products.delete(product_name)
      else
        return @products
      end
    end

    # class method
    # returns a collection of order instances, representing all the orders
    # in the CSV file
    def self.all
      all_orders = []

      CSV.open("support/orders.csv", "r").each do |line|
        # puts "Read line #{line}"
        id = line[0].to_i
        product_array = line[1].split(/;|:/)
        # puts "decoded to id #{id}, products #{product_array}"

        product_hash = {}
        product_name = nil
        product_array.each_with_index do |value, i|
          if i % 2 == 0
            product_name = value
          elsif i % 2 == 1
            product_hash[product_name] = value.to_f
          end
        end

        puts "turned product array into hash #{product_hash}"

        order = Order.new(id, product_hash)
        all_orders << order
        puts
      end


    end

    # self.find(id) - returns an instance of Order
    # where the value of the id field in the CSV matches the passed parameter.


    def self.find(order_num)
      # all_orders = []
      order_num_array = []

      CSV.open("support/orders.csv", "r").each do |line|
        # puts "Read line #{line}"
        id = line[0].to_i
        order_num_array << id
      end

      if order_num_array.include?(order_num)
        puts "Great we have your order!"
        CSV.open("support/orders.csv", "r").each do |line|
          id = line[0].to_i
          if id == order_num
            product_array = line[1].split(/;|:/)

            product_hash = {}
            product_name = nil
            product_array.each_with_index do |value, i|
              if i % 2 == 0
                product_name = value
              elsif i % 2 == 1
                product_hash[product_name] = value.to_f
              end
            end
            puts "The products for order #{id} are: #{product_hash}"
          end
        end
    # when Order.find is called with an ID that doesn't exist?
      else
          puts "Sorry, it appears we don't have an order #{order_num}."
      end
    end
  end
end

order = Grocery::Order.find(101)



### additional code that I worked on to try to get things to run ###

### create 2 loops to split string into useful data sets
## created a series of arrays within a hash, within another hash
# hash = {}

# CSV.open("support/orders.csv", "r").each do |line|
#    hash[line[0].to_i] = line[1]
#  end
#
# hash.each do |k, v|
#   hash[k] = v.split(";")
# end
#
#
# hash.each do |k,v|
#   #product_hash = {}
#   v.each do |string|
#     order = string.split(":")
#     myOrder[order[0]] = order[1].to_f
#   end
#   hash[k] = product_hash
# end
#
# puts hash



#   CSV.open("support/orders.csv", "r").each do |line|
#     string = line[1..-1]
#     string.split(/;|:/)
#
#   hash.each do |k, v|
#     @@array << v
#   end
#   return @@array
# end


#
#
# object = Grocery::Order.new(1, {"banana" => 1.99, "cracker" => 3.00 })
# puts object.id
# puts object.products


# CSV.open("support/orders.csv", "r").each do |line|
#   # hash[line[0].to_i] = line[1]
#   string = line[1].split(/;|:/)
#   print string
#   # hash[line[0]] = string
#   # print hash
#   string.each_with_index do |value, i|
#     if i % 2 == 0
#       data << value.to_s
#     elsif i % 2 == 1
#       data << value.to_f
#     end
#   end
#       all_order << Order.new(hash[line[0].to_i],data)
#       return all_order
# end
# end
