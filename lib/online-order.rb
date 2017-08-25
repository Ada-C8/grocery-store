require 'csv'
require_relative 'order.rb'
require_relative 'customer.rb'
require 'pry'

module Grocery
  class OnlineOrder < Order
    attr_reader :id, :products, :customer, :status

    def initialize(id, products, customer, status: :pending)
      @id = id
      @products = products
      @status = status
      @customer = Grocery::Customer.find(customer)
    end

    def total
    unless @products.count == 0
      total = super + 10
      return total
    end
    end

    def add_product(product_name, product_price)
      if @status == :pending || @status == :paid
        super
      else
        raise ArgumentError.new ("You may only add products to paid or pending orders.")
      end
    end

    def self.all
      all_online_orders = []
      CSV.open("/Users/kimberley/ada/week-three/grocery-store/support/online_orders.csv", "r").each do |line|
        id = line[0]
        id = id.to_i
        all_products = line[1].split(";")
        products = []

        all_products.each do |all_products|
          item_pair = all_products.split(":")
          item_with_cost = {item_pair[0] => item_pair[1]}
          products << item_with_cost
        end

        customer = line[2]
        status = line[3].to_sym

        online_order = Grocery::OnlineOrder.new(id, products, customer, status: status)
        all_online_orders << online_order
      end
      return all_online_orders

    end

    def self.find(id)
      if id > self.all.count || id.to_i < 1
        raise ArgumentError.new ("That customer ID does not exist.")
      end
      index = id - 1
      return Grocery::OnlineOrder.all[index]
    end

    # self.find_by_customer(customer_id) - returns a list of OnlineOrder instances where the value of the customer's ID matches the passed parameter.
    def self.find_by_customer(customer_id)
      if customer_id.to_i > Grocery::Customer.all.count || customer_id.to_i < 1
        raise ArgumentError.new ("That customer ID does not exist.")
      end


      customer_orders = []
      Grocery::OnlineOrder.all.each do |onlineorder|
        if onlineorder.customer.to_i == customer_id
          customer_orders << onlineorder
        end
      end
      return customer_orders
    end

  end #end of class
end # end of module

online_order = Grocery::OnlineOrder.new(53, {"banana" => 1.99, "cracker" => 3.00}, 24, status: :paid)
puts Grocery::OnlineOrder.all[26].customer.address

# puts Grocery::OnlineOrder.all
# online_order = Grocery::OnlineOrder.new(53, {"banana" => 1.99, "cracker" => 3.00}, 24, status: :paid)
# puts online_order.products.count
