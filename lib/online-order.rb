require 'csv'
require_relative 'order'
require_relative 'customer'

module Grocery
  class OnlineOrder < Order
    attr_reader :customer_id, :status, :id, :products, :product_list, :customer
    def initialize(id, products)
      super
      @customer = Customer.find(products[1])
      @status = products[2]
      @products = products[0]
    end


    def self.all
      CSV.read("../support/online_orders.csv").each do |row|
        myord = OnlineOrder.new(row[0], row[1..-1])
        puts myord.products



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

    # def add_product(product_name, product_price)
    #   if self.status == :pending || self.status == :paid
    #     super
    #     return true
    #   end
    #   raise ArgumentError.new("Order's status is #{self.status.to_s}.")
    # end
    # def total
    #   total = super
    #   return total + 10
    # end
  end
# myord = OnlineOrder.new("1", "prod:2; prad:3;20;prending")
# puts myord.id
# puts myord.products
puts OnlineOrder.all

end
