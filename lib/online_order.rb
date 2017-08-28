require 'csv'
require 'awesome_print'
require_relative 'order'
require_relative 'customer'

module Grocery

  class OnlineOrder < Order

    attr_reader :online_id, :products, :customer, :status

    def initialize(online_id, products, customer_id, status = :pending) #Argument default notation: http://ruby-doc.com/docs/ProgrammingRuby/html/tut_methods.html (Error arises if notation is status: :complete; notation from github: https://docs.google.com/document/d/1Jtb8Pz6QZuktP48bdFiLvsx-UCSyXZ_COWeEX4Ftcxs/edit)
      @online_id = online_id
      @products = products #a collection of products and their cost -> products = {product_name: cost}
      @customer = Grocery::Customer.find(customer_id) #Using CSV customer_id number to pass a customer object by finding the instance of customer from customer.rb

      status_types = [:pending, :paid, :processing, :shipped, :complete]
      if status_types.include?(status) == false #if status is not a valid type in status_types array, raise an ArgumentError
        raise ArgumentError.new("Orders must have a valid status")
      end
      @status = status #status types: :pending (default), :paid, :processing, :shipped or :complete
    end

    def total
      if @products.length == 0
        online_order_total = 0
      elsif @products.values != 0 || @products.values != nil
        online_order_total = super + 10
      else #anything else not specified above
        online_order_total = 0
      end
      return online_order_total
    end

    #Why does this block of the total method code fail?
    # def total
    #   if @products.values != 0 && @products.values != nil
    #     online_order_total = super + 10
    #   elsif @products.length == 0
    #     online_order_total = 0
    #   else
    #     online_order_total = 0
    #   end
    #   return online_order_total
    # end

    def add_product(product_name, product_price)
      if status == :pending || status == :paid
        super
      else
        raise ArgumentError.new("Order can only be added to pending or paid statuses")
      end
    end

    def self.all
      online_orders = CSV.read('/Users/janedrozo/Desktop/grocery-store/support/online_orders.csv', converters: :numeric)
      #generates each row as an array w/ numbers no longer as strings:
      #[ 1, "Lobster:17.18;Annatto seed:58.38;Camomile:83.21", 25, "complete"]

      all_online_orders = []

      online_orders.each do |row|
        online_id = row[0]
        items = row[1].split(';')
        #generates when you enter: puts items.to_s
        #["Lobster:17.18", "Annatto seed:58.38", "Camomile:83.21"]

        products = {} #products hash {product_name: product_price}

        items.each do |item|
          product_price = item.split(":")
          #generates:
          #[["Lobster", "17.18"], ["Annatto seed", "58.38"], ["Camomile", "83.21"]]
          product_name = product_price[0]
          price = product_price[1]
          #set key-value pair for products {}
          products[product_name] = price.to_f
        end

        customer = row[2]
        status = row[3].to_sym

        all_online_orders << Grocery::OnlineOrder.new(online_id, products, customer, status)

      end

      return all_online_orders #returns a collection of OnlineOrder instances
    end

    def self.find(online_id)
      online_orders = Grocery::OnlineOrder.all

      online_orders.each do |order_instance|
        if order_instance.online_id == online_id
          return order_instance
        end
      end
      #if we go through the loop without finding a match, then we raise an error
      raise ArgumentError.new("ONLINE ORDER ##{online_id} NOT FOUND!")
    end

    #Returns an array of online orders for a specific customer ID
    def self.find_by_customer(specific_customer_id)
      all_online_orders = Grocery::OnlineOrder.all

      online_orders_for_customer_id = []

      all_online_orders.each do |online_order|
        if online_order.customer.customer_id == specific_customer_id
          online_orders_for_customer_id << online_order
        end
      end

      return online_orders_for_customer_id

      #if we go through the loop without finding a match, then we raise an error
      raise ArgumentError.new("CUSTOMER ##{customer_id} NOT FOUND!")
    end

  end#of_OnlineOrder_class

end#of_Grocery_module

#TEST
# ap Grocery::OnlineOrder.all
# ap Grocery::OnlineOrder.find_by_customer(26)
