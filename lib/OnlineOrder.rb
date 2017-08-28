require 'csv'
require 'order'
require 'pry'
require_relative 'order'
require_relative 'Customer'

module Grocery
  class OnlineOrder < Order
    attr_reader :id, :products, :customer_id, :status, :customer

    def initialize(id, products, customer_id, status = :pending)
      @id = id.to_i
      @products = products
      @customer_id = customer_id.to_i
      @status = status.to_sym
      # The assignment instructs us to make a Customer object in the OnlineOrder
      # class. I was unsure what to do so I did my best. See the line below.
      @customer = Grocery::Customer.all
    end

    # Total via inheritance
    def total
      # if the products hash is empty then fee equals 0
      if super == 0
        return 0
      else
        return super + 10.00
      end
    end # total

    def add_product(product_name, product_price)
      if @status == :pending || @status == :paid
        return super
      else
        return raise ArgumentError.new("Sorry. No prodects can be added at this time because ...")
      end
    end

    def self.all
      online_orders = []
      CSV.open("support/online_orders.csv", 'r').each do |order|
        order_id = order[0].to_i
        customer_id = order[2].to_i
        status = order[3]

        products = order[1].split(";")
        products_hash = {}

        products.each do |product_colon_price|
          a = product_colon_price.split(":")
          products_hash[a[0]] = a[1].to_f
        end
        online_orders << self.new(order_id, products_hash, customer_id, status)
      end
      return online_orders
    end

    def self.find(id)
      self.all.each do |order|
        if id == order.id
          return order
        end
      end
      raise ArgumentError.new("No order id found")
    end

    def self.find_by_customer(customer_id)
      customer_online_orders = []
      self.all.each do |order|
        if customer_id == order.customer_id
          customer_online_orders << order
        end
      end
      return customer_online_orders
    end
  end # class
end # module

puts Grocery::OnlineOrder.find_by_customer(1)

# puts new_order = Grocery::OnlineOrder.all
#
# new_order1 = Grocery::OnlineOrder.new(1, {"g" => 1.00}, 2, "shipped")
#
# puts new_order
