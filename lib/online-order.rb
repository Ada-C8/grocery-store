require 'csv'
require_relative 'order'
require_relative 'customer'

module Grocery
  class OnlineOrder < Order
    attr_reader :id, :products, :product_list, :status, :customer
    def initialize(id, products)
      @id = id
      @products = products
      split_order_info(@products)
      get_order_status(@product_list)
      get_customer(@product_list)
      get_products(@product_list)
      # @customer
      @status


      # @product_list = products.split(",")
      # split_order_info(@products)
      # @status = @product_list.pop.to_sym
      # @customer Customer.find(@product_list.pop.to_s)
    #   @products = {}
    #   @product_list2 = @product_list.join.split(";")
    #   @product_list2.each do |productandprice|
    #    prodprice_arr = productandprice.split(":")
    #    @products[prodprice_arr[0]] = prodprice_arr[1]
    #  end
    end

    def split_order_info(products)
        @product_list = products.join(";").split(";")
        return @product_list
    end
    def get_order_status(info_array)
      @status = @product_list.pop.to_sym
      return @status
    end
    def get_customer(info_array)
      @customer = Customer.find(info_array.pop.to_s)
    end
    # def get_products(info_array)
    #   @products = {}
    #   product_list2 = @product_list.join.split(";")
    #   product_list2.each do |productandprice|
    #     prodprice_arr = productandprice.split(":")
    #     @products[prodprice_arr[0]] = prodprice_arr[1]
    #   end
    #   return@products
    # end
    #
    def self.all
      list = []
      CSV.read("./support/online_orders.csv").each do |row|
        list << OnlineOrder.new(row[0], row[1..-1])
      end
      list
    end

    def self.find_by_customer(customer_id)
      list = []
      all.each do |online_order|
        if online_order.id == customer_id
          list << online_order
        end
      end
      if list.empty?
        raise ArgumentError.new("This customer doesn't exist.")
      else
        return list
      end
    end

    def add_product(product_name, product_price)
      if self.status == :pending || self.status == :paid
        super
        return true
      else
        raise ArgumentError.new("Order's status is #{self.status.to_s}.")
      end
      return true
    end

    def total
      total = super
      return total + 10
    end
  end



#
#
# puts OnlineOrder.find_by_customer("2")
#  myord = OnlineOrder.new(CSV.read("support/online_orders.csv")[1][0],CSV.read("support/online_orders.csv")[1][1..-1])
# puts myord.products
# puts myord.product_list
# puts myord.status
# puts myord.status
# puts myord.customer
# puts myord.products
# puts myord.status
#  puts myord.add_product("nameofprod","45")
#  puts myord.total
# puts myord.id
# puts myord.products
# puts OnlineOrder.all


end
