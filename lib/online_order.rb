require_relative 'order.rb'
require_relative 'customer.rb'
require 'awesome_print'

module Grocery
  class OnlineOrder < Grocery::Order

    attr_reader :id, :customer, :status, :products

    def initialize(id, products, customer_id, status)
      super(id, products)
      @customer = get_customer(customer_id)
      @status = status
    end

    def self.all(csv_file)
      online_orders = Array.new
      CSV.read(csv_file).each do |purchase_array|
        order_id = purchase_array[0].to_i
        customer_id = purchase_array[2].to_i
        status = purchase_array[3]
        products_list = purchase_array[1].split(";")
        products = {}
        products_list.each do |product|
          product_with_price = product.split(":")
          products[product_with_price[0]] = product_with_price[1].to_f
        end
        online_orders << Grocery::OnlineOrder.new(order_id, products,customer_id, status)
      end
      return online_orders
    end

    def self.find(id, csv_file)

    end

    def self.find_by_customer(customer_id)

    end

    def get_customer(customer_id)
      return Grocery::Customer.find(customer_id, './support/customers.csv')
    end

    def total
      total = super
      if total == 0
        return 0
      else
        total += 10
      end
      return total
    end

    def add_product
      if @status == "pending" || @status == "paid"
        super
      else
        raise ArgumentError.new "I'm sorry, you may no longer add to this order."
      end
    end

  end
end

# orders = Grocery::OnlineOrder.all('./support/online_orders.csv')

# online_order = Grocery::OnlineOrder.new(10, {"Jerusalem Artichoke" => 59.92}, 26, "complete")

# p online_order.customer.class
