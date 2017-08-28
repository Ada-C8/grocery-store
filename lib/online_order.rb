require 'csv'
require_relative 'customer'
require_relative 'order'

module Grocery
  class OnlineOrder < Grocery::Order

    attr_reader :customer, :status

    def initialize(id, products, customer, status = :pending)
      @id = id
      @products = products
      @customer = customer
      @status = status
    end

    # Calculates the total price of products + sales tax
    def total
      total = super
      total != 0 ? total += 10 : total = 0
    end

    # Adds a product to the product list
    def add_product(product_name, product_price)
      if @status == :pending || @status == :paid
        new_product = { product_name => product_price }
        can_successfully_add = false
        @products.has_key?(product_name) ? can_successfully_add = false : can_successfully_add = true
        if can_successfully_add
          @products.merge!(new_product) { |key, old_value, new_value| old_value }
        end
        return can_successfully_add
      end
      raise ArgumentError.new("Status is neither pending nor paid")
    end

    # Reads from CSV file and returns a list of all Online Orders
    def self.all
      all_orders = []
      CSV.read("support/online_orders.csv").each do |order|
        #0 id, 1 product string, 2 customer id, 3 status
        id = order[0].to_i
        products = {}
        @item_price_array = order[1].split(";")
        @item_price_array.each do |product|
          split_product = product.split(":")
          item = split_product[0]
          price = split_product[1]
          product_hash = {item => price}
          products.merge!(product_hash)
        end
        customer = Grocery::Customer.find(order[2].to_i)
        status = order[3].to_sym
        all_orders << Grocery::OnlineOrder.new(id, products, customer, status)
      end
      return all_orders
    end

    #inherits self.find from Order class

    # Takes in a customer's ID and returns a list of their orders
    def self.find_by_customer(customer_id)
      #error if customer id doesn't existing
      if Grocery::Customer.all.length < customer_id || customer_id == 0
        raise ArgumentError.new("Customer with ID #{customer_id} does not exist.")
      end
      all_online_orders = self.all
      customer_orders = []
      all_online_orders.each do |order|
        if order.customer.id == customer_id
          customer_orders << order
        end
      end
      return customer_orders
    end

  end
end
