require "money"
require "csv"
# require_relative "support/orders.csv"
Money.use_i18n = false

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      # TODO: implement total
      sum = products.values.inject(0, :+)
      total = (sum + (sum * 0.075)).round(2)
      return total
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
      if @products.has_key?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)
      # TODO: implement delete_product
      if @products.has_key?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

    def self.all
      orders = []
      CSV.open("support/orders.csv", "r").each do |line|
        data = []
        string = line[1]
        product_data = string.split(/:|;/)
        product_data.each_with_index do |datum, i|
          if i % 2 == 0
            data << datum.to_s
          elsif i % 2 == 1
            data << datum.to_f.round(2)
          end
        end
        order = new(line[0].to_i, Hash[*data])
        orders.push(order)
      end
      return orders
    end

  #   orders = Grocery::Order.all("support/orders.csv")
  #  puts orders[0].products
    # def self.all
    #   orders = []
    #   data = []
    #   file = CSV.open("support/orders.csv", "r")
    #   file.each do |line|
    #   # CSV.open("support/orders.csv", "r").each do |line|
    #     # @orders[line[0]] =
    #     string = line[1]
    #     product_data = string.split(/:|;/)
    #     product_data.each_with_index do |datum, i|
    #       if i % 2 == 0
    #         data << datum.to_s
    #       elsif i % 2 == 1
    #         data << datum.to_f
    #       end
    #     end
    #     order = Grocery::Order.new(line[0].to_i, Hash[*data])
    #     orders.push(order)
    #   end
    #   return orders
    # end

    def self.find(id)
      # TODO: check about file passing
      orders = self.all
      if id > orders.length || id <=0
        raise ArgumentError.new('Invalid ID.')
      else
        return orders[id-1]
      end
    end

  end
end

# puts Grocery::Order.find(1).products
# puts Grocery::Order.find(101)

# puts Grocery::Order.all('support/orders.csv')[99].products

# require "money"
# require "csv"
# # require_relative "support/orders.csv"
# Money.use_i18n = false
#
# module Grocery
#   class Order
#     attr_reader :id, :products
#     # , :orders, :data
#     # @orders = []
#     # @data = []
#
#     def initialize(id, products)
#       @id = id
#       @products = products
#     end
#
#     # i = 0
#     # def add_file
#     # CSV.open("support/orders.csv", "r").each do |line|
#     #   # @orders[line[0]] =
#     #   string = line[1..-1].join
#     #   product_data = string.split(/:|;/)
#     #   product_data.each_with_index do |datum, i|
#     #     if i % 2 == 0
#     #       @data << datum.to_s
#     #
#     #     elsif i % 2 == 1
#     #       @data << datum.to_f
#     #     end
#     #   end
#     #   order = Grocery::Order.new(line[0], Hash[*@data])
#     #   @orders.push(order)
#
#       # order = Grocery::Order.new(line[0], Hash[*])
#       # @orders.push(order)
#       # @orders[0].@products.map { |key, value| value }
#       # { |k, v| [k.to_s, v.to_f] }
#       # i += 1
#     # end
#     # end
#
#     # puts @orders.length
#
#     # puts @orders[1].id
#     # puts @orders[1].products
#     # puts @orders[2].id
#     # puts @orders[2].products
#
#     def total
#       # TODO: implement total
#       # values = []
#       # products.values.each do |value|
#       #   values << value.to_f
#       # end
#       # sum = values.inject(0, :+)
#       sum = products.values.inject(0, :+)
#       total = (sum + (sum * 0.075)).round(2)
#       return total
#     end
#     # puts @orders[0].total
#     # puts @orders[0].products
#
#     def add_product(product_name, product_price)
#       # TODO: implement add_product
#       if @products.has_key?(product_name)
#         return false
#       else
#         @products[product_name] = product_price
#         return true
#       end
#     end
#     def remove_product(product_name)
#       # TODO: implement delete_product
#       if @products.has_key?(product_name)
#         @products.delete(product_name)
#         return true
#       else
#         return false
#       end
#     end
#     def self.all
#       orders = []
#       data = []
#       CSV.open("support/orders.csv", "r").each do |line|
#         # @orders[line[0]] =
#         string = line[1..-1].join
#         product_data = string.split(/:|;/)
#         product_data.each_with_index do |datum, i|
#           if i % 2 == 0
#             data << datum.to_s
#           elsif i % 2 == 1
#             data << datum.to_f
#           end
#         end
#         order = Grocery::Order.new(line[0].to_i, Hash[*data])
#         orders.push(order)
#       end
#       return orders
#     end
#
#     def self.find(id)
#       orders = Grocery::Order.all
#       if id > orders.length || id <=0
#         raise ArgumentError.new('Invalid ID.')
#       else
#         return orders[id-1]
#       end
#     end
#   end
# end
