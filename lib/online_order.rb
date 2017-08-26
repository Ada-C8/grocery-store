require_relative 'Order'
require 'csv'

#The fact that I am redefining the methods OnlineOrder inherits from Order is why I am getting all the warning messages when I run rake

module Grocery
  class OnlineOrder < Order
      attr_reader :customer_id, :status, :customer

#TODO: is this the right way to set a default argument parameter?
    def initialize(id, products, customer_id, status = :pending)
      super(id, products)
      #took out customer_id since I am using @customer now
      # @customer_id = customer_id
      @status = status
      @customer = Grocery::Customer.find(customer_id) #so that we use an instance of the Customer class instead of just the customer_id in the csv file to access data about each customer
    end #initialize

#Modifying the total method so that a shipping cost will only be added if super returns a value grater than 0 (meaning that there are products in the order)
    def total
      if super == 0
        return 0
      else
        return super + 10
      end #if/else
    end #total

    def add_product(products, price)
      if @status == :processing || @status == :shipped || @status == :completed
        raise ArgumentError.new("Error: you cannot add to you order because it is allready #{@status}")
      else
        super
      end #if/else
    end #add_product

    #TODO is it OK that I just totally rewrote the self.all method? Should I have used super? I didn't know how to do this cause they changes I would have needed to make to the file would be within the functionality of super....
    #Similar to self.all in Order, but we also have the customer_id and the status in the csv file.
    def self.all
      #Need to give this it's own class variabel so we don't mess with the regular orders
      all_online_orders = []

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
        status = line[3].to_sym

        all_online_orders << Grocery::OnlineOrder.new(id, products, customer_id, status)
      end #.open
      return all_online_orders
    end #self.all

    #Add this method so that the same self.find method in Order and OnlineOrder can access differnt arrays! I will override this method in the OnlineOrder class to return all_online_orders
    def self.return_csv_array
      return self.all
    end


    def self.find(id)
      # self.find(id) - returns an instance of OnlineOrder where the value of the id field in the CSV matches the passed parameter. -Question Ask yourself, what is different about this find method versus the Order.find method?
      super(id)
    end #self.find


    def self.find_by_customer(customer_id_find)
      # self.find_by_customer(customer_id) - returns a list of OnlineOrder instances where the value of the customer's ID matches the passed parameter.

      #Code below was changed to use the @customer instead of @customer_id. @customer_id is accessed though instances of the customer 
      all_online_orders = self.all
      customer_orders = []
      if all_online_orders.any?{|instance| instance.customer.customer_id == customer_id_find.to_s}
        all_online_orders.each do |order|
          if order.customer.customer_id == customer_id_find
            customer_orders << order
          end #if
        end #.each
      else
        raise ArgumentError.new("Error: There are no orders for the customer with ID #{customer_id_find}!")
      end #if/else
      return customer_orders


      #Code below is from before I initiated instances of the customer and was using customer_id instead
      # all_online_orders = self.all
      # customer_orders = []
      #
      # if all_online_orders.any?{|instance| instance.customer_id == customer_id_find.to_s}
      #   all_online_orders.each do |order|
      #     if order.customer_id == customer_id_find
      #       customer_orders << order
      #     end #if
      #   end #.each
      # else
      #     raise ArgumentError.new("Error: order #{customer_id_find} does not exsist!")
      # end #if/else
      # return customer_orders
    end #self.find_by_customer

  end #OnlineOrder
end #Grocery
