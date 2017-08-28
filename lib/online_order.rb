# online_order
require 'csv'
require 'awesome_print'

require_relative 'order.rb'
require_relative 'customer.rb'

module Grocery
  class Onlineorder < Order
    attr_reader :customer, :status
    def initialize(id, products, customer, status)
      # @id = id
      # @products = products
      super(id, products)
      @customer = customer
      @status = status
    end

    # line 29 is plopping the customer class in place of the customer ID. So now when customer.id is called i can call all of the attributes in the customer class such as id, email and address.
    def self.all
      @orders = []
      CSV.open('/Users/Marisa/documents/ada developers academy/projects/grocery-store/support/online_orders.csv', 'r').each do |online_attributes|
        online_order = Grocery::Onlineorder.new(
        online_attributes[0].to_i,
        online_attributes[1].split(";").map do |item|
          product_array = item.split(":")
          {name: product_array[0], price: product_array[1].to_f.round(2)}
        end,
        Grocery::Customer.find(online_attributes[2].to_i),
        online_attributes[3].to_sym
        )
        @orders << online_order
      end
      ap @orders
      return @orders
    end #self.all method end



    def self.find(id)
      @orders.each do |online_order|
        if (id == online_order.id)
          return online_order
        end
      end
      raise ArgumentError.new("You messed up!")
    end #self.find method end



    def self.find_by_customer(id)
      @orders.each do |online_order|
        if (customer_id == online_order.customer.id)
          return online_order
        end
      end
    end


    def total
      # inheritance - update so it adds the tax on to the total
      super + 10
    end #total method end


  end #class end
end #module end

Grocery::Onlineorder.all
