# online_order
require 'csv'
require 'awesome_print'

require_relative 'order.rb'
require_relative 'customer.rb'

module Grocery
  class Onlineorder < Order
    attr_reader :id, :products, :customer_id, :status
    def initialize(id, products, customer_id, status)
      @id = id
      @products = products
      @customer_id = customer_id
      @status = status
    end

      def self.all
        @online_orders = []
        CSV.open('/Users/Marisa/documents/ada developers academy/projects/grocery-store/support/online_orders.csv', 'r').each do |online_attributes|
          online_order = Grocery::Onlineorder.new(
          online_attributes[0].to_i,
          online_attributes[1],
          online_attributes[2].to_i,
          online_attributes[3].to_sym
          )
          @online_orders << online_order
        end
        ap @online_orders
        return @online_orders
      end #self.all method end


      def self.find(id)
        @online_orders.each do |online_order|
          if (id == online_order.id)
            return online_order
          end
        end
        raise ArgumentError.new("You messed up!")
      end #self.find method end


      def self.find_by_customer(id)
        @online_orders.each do |online_order|
          if (customer_id == online_order.customer_id)
            return online_order
          end
        end
      end


      def total
        #inheritance - update so it adds the tax on to the total
        # super + 10
        # sum = @products.values.inject(0, :+)
        # expected_total = sum + (sum * 0.075).round(2)
      end #total method end


  end #class end
end #module end

Grocery::Onlineorder.all
