require 'csv'
require_relative 'order'
require_relative 'customers'

module Grocery
  class OnlineOrder < Order
    @@csv = "../support/online_orders.csv"
    attr_reader :id, :products, :customer
    attr_accessor :status

    def initialize(id, products, status = :pending, customer)
      @id = id
      @products = products
      @status = status
      @customer = customer
    end

    def self.all
      super
    end

    def self.find(id)
      super
    end

    def self.find_by_customer(customer_id)
      customer = Grocery::Customer.find(customer_id)
      customer_orders = []

      Grocery::OnlineOrder.all.each do |order|
        if order.customer == customer.id
          customer_orders << order
        end
      end
      return customer_orders
    end

    def total
      if products.empty?
        return 0
      else
        super + 10
      end
    end

    def add_product(name, price)
      if @status == :paid || @status == :pending
        super
      else
        raise ArgumentError.new("Sorry, this cannot be added to your order")
      end
    end

  end
end
