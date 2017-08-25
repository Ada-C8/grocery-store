require_relative 'Order'
require 'csv'

module Grocery
  attr_reader :customer_id, :status
  @all_online_orders = []
  class OnlineOrder < Order
    def initialize(id, products, customer_id, status)
      super(id, products)
      @customer_id = customer_id
      @status = status
    end #initialize

    #I had to make this method cause the attr_reader didn't work. Why is that??
    def customer_id
      return @customer_id
    end #customer_id

    #I had to make this method cause the attr didn't work (same at for customer_id). Why??
    def status
      return @status
    end #status

    def total
      if super == 0
        return 0
      else
        return super + 10
      end #if/else
    end #total

    def add_product(products, price)
      if @status == "processing" || @status == "shipped" || @status == "completed"
        raise ArgumentError.new("Error: you cannot add to you order because it is allready #{@status}")
      else
        super
      end #if/else
    end #add_product

#TODO is it OK that I just totally rewrote the self.all method? Should I have used super?
    def self.all
      #Need to give this it's own class variabel so we don't mess with the regular orders
      @all_online_orders = []

      CSV.open("support/online_orders.csv", 'r').each do |line|
        id = line[0]
        order_products = {}

        products = line[1].split(";")
        products.each do |item_price|
          product_price = item_price.split(":")
          order_products[product_price[0]] = product_price[1].to_f
        end #.each

        products = order_products
        customer_id = line[2]
        status = line[3]

        @all_online_orders << Grocery::OnlineOrder.new(id, products, customer_id, status)
      end #.open
      return @all_online_orders
    end #self.all

    def self.find(id)
      # self.find(id) - returns an instance of OnlineOrder where the value of the id field in the CSV matches the passed parameter. -Question Ask yourself, what is different about this find method versus the Order.find method?

      #TODO: is there a way to change the variable name called in the super method from @all_orders to @all_online_orders?
      #TODO: or do I need to raname @all_online_orders to @@all_orders in OnlineOrder and recall it before super to redefine it within the self.find method?
      super(id)
    end #self.find
end #OnlineOrder
end #Grocery

online_order = Grocery::OnlineOrder.new("3", {apple: 2, pear: 3}, "1", "Paid")
puts online_order.customer_id
# 1,Lobster:17.18;Annatto seed:58.38;Camomile:83.21,25,complete
