require 'csv'
require_relative 'order'


module Grocery
  class OnlineOrder < Order
    attr_reader :status, :customer_id, :customer

    def initialize(id, products, customer_id, status = :pending)
      super(id, products)
      @status = status
      @customer = customer #Grocery::Customer.find(customer_id) #Customer.new
    end

    def total
      shipping_fee = 10
      if super == 0
        return 0
      else
        return super + shipping_fee
      end
    end

    def add_product(product_name, product_price)
      if (@status == :processing) || (@status == :shipped) || (@status == :completed)
        raise ArgumentError.new("Products cannot be added")
      else
        super
      end
    end

    def self.all
      online_orders = []
      CSV.open("support/online_orders.csv", 'r').each do |line|
        products = {}
        id = line[0].to_i
        # puts id

        line[1].split(";").each do |product_info|
          data = product_info.split(":")
          products[data[0]] = data[1].to_f
        end

        customer_id = line[2]
        # print customer_id
        status = line[3].to_sym
        puts status
        online_orders << Grocery::OnlineOrder.new(id, products, customer_id, status)
      end
      return online_orders
    end

    def self.find(id)
      super(id)
    end

    def self.find_by_customer(customer_id)
      customer_orders = []
      online_orders = self.all
      if online_orders.any? {|instance| instance.customer.customer_id == customer_id_find.to_s}
        customers.each do |order|
          if order.customer.customer.id == customer_id
            customer_orders << order
          end
        end
      else
        raise ArgumentError.new("Customer order does not exist")
      end
      return customer_orders
    end


  end #end of class
end #end of module


# customer_order = Grocery::OnlineOrder.find_by_customer(25)
# puts customer_order
# customer = customers[-1].id
# print customer
# online_order = Grocery::OnlineOrder.new(customer, status)
# puts online_order.customer
