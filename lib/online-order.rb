require 'csv'
require_relative 'customer'
require_relative 'order'

module Grocery
  class OnlineOrder < Order
    attr_reader :customer
    attr_accessor :status

    def initialize(order_id, products, customer, status = :pending)
      super(order_id, products)
      @customer = customer
      @status = status
    end

    def total
      # adds $10 shipping fee to order
      shipping = 10
      return super + shipping
    end

    def add_product(product_name, product_price)
      # only adds product if status is pending or paid; returns false if can't be added
      if @status == :pending || @status == :paid
        super
      else
        raise ArgumentError.new("Can only add product to an order that is pending or paid")
      end
    end

  end # end of OnlineOrder class
end

# cust = Grocery::Customer.new(1, "name@gmail.com", ["num street", "city", "state", "zip"])
# oo = Grocery::OnlineOrder.new(1, { "Almonds" => 4.0 }, cust)
#
# puts "email is #{oo.customer.email}"
# puts "status"
# puts oo.status
#
# puts oo.id
# puts oo.products
# puts oo.total
#
# puts oo.add_product("Milk", 4.99)
# puts oo.products
#
# oo.status = :shipped
# puts oo.add_product("Banana", 0.59)
# puts oo.products
