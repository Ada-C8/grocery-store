require 'csv'
require_relative 'order'
require_relative 'customer'

module Grocery
  class OnlineOrder < Order
    attr_reader :customer_id, :status, :id, :products, :product_list, :customer
    def initialize(id, products)
      super
      @product_list = products.split(",")
      @status = @product_list.pop.to_sym
      @customer = Customer.find(@product_list.pop.to_s)
      @products = {}
      @product_list2 = @product_list.join.split(";")
      @product_list2.each do |productandprice|
       prodprice_arr = productandprice.split(":")
       @products[prodprice_arr[0]] = prodprice_arr[1]
     end

    end


    def self.all
      list = []
      CSV.read("../support/online_orders.csv").each do |row|
        list << OnlineOrder.new(row[0], row[1..-1].join(","))
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

    # def self.find_by_customer(customer_id)
    #   found = false
    #   CSV.read("../support/online_orders.csv").each do |row|
    #     if row[2] == customer_id
    #       puts Order.new(row[0], row[1..-1])
    #       found = true
    #     end
    #   end
    #   if found == false
    #     raise ArgumentError.new("This customer doesn't exist.")
    #   end
    # end

    # def self.find_by_customer(customer_id)
    #   self.all.customer.class
    # end

    def add_product(product_name, product_price)
      if self.status == :pending || self.status == :paid
        super
        return true
      end
      raise ArgumentError.new("Order's status is #{self.status.to_s}.")
    end
    def total
      total = super
      return total + 10
    end
  end
#myord = OnlineOrder.new("1", "prod:2;prad:3,1,pending")

# puts myord.status
# puts myord.customer
# puts myord.products
# puts myord.status
#  puts myord.add_product("nameofprod","45")
#  puts myord.total
# puts myord.id
# puts myord.products
# puts OnlineOrder.all

puts OnlineOrder.find_by_customer("2")
# puts OnlineOrder.find("edss")
 # myord = OnlineOrder.new(CSV.read("../support/online_orders.csv")[0][0],CSV.read("../support/online_orders.csv")[0][1..-1].join(","))
# puts myord.products
# puts myord.product_list
# puts myord.status


end
