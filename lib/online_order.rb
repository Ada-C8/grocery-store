require 'csv'
require_relative 'order'
#require_relative 'customer'

module Grocery
  class OnlineOrder < Order
    attr_reader :status, :customer_id, :products, :id

    def initialize(id, products, customer_id, status = :pending)
      super(id, products)
      @customer_id = customer_id
      @status = status
      # maybe put in status options there
    end

    #total inherits from Grocery::Order#total, which sums the products, adds
    # a 7.5% sales tax, and rounds to two decimal places. Total here
    # adds an additional 10$ shipping fee, if the order is not empty.
    def total
      if products != {}
        total = super + 10
      else
        total = super
      end
      return total
    end

    #add_product inherits from Grocery::Order.add_product, but halts the adding
    #if the products have a status of processing, shipped or complete
    def add_product(product_name, product_price)
      changes_prohibited = [:processing, :shipped, :complete]
      if changes_prohibited.include?(status)
        puts "No changes can be made to the order at this time."
      else
        super
      end
    end

    #self.all returns a collection of Customer instances, representing all
    # of the Customer described in the CSV.
    def self.all
      #csv format =
      # order_id,item_name:price;item_name:price,customer_id,status.
      #
      #The number of item_name and price pairs can vary.
      #Goal:
      #(order_id, ({item_name1 => price1},{item_name2 => price2},...), customer_id, :status)
      #1. Open the file and get the order_id, customer_id and status
      csv_array_all_online_orders = []
      CSV.open("support/online_orders.csv", 'r').each do |line|
        product = Hash.new
        id = line[0].to_i
        status = line[-1]
        customer_id = line[-2].to_i
        all_items_and_prices = line[1...-2]
        #2. Parse out the product_name and cost, store each pair in a hash
        item_and_price = all_items_and_prices.to_s.split(";")
        item_and_price.each do |item_price|
          item = item_price.split(":")[0]
          item = item.delete("[").delete("\"")
          price = item_price.split(":")[1]
          price = price.delete("]").delete("\"")
          product[item] = price.to_f
        end
        #3. Put all the information for one online order in a array
        current_order = [id, product, customer_id, status]
        #4. put the arrays of online orders into an array
        csv_array_all_online_orders << current_order
      end
      #5. create a new instance of OnlineOrder for each element in the array in 4
      all_online_orders = []
      csv_array_all_online_orders.each do |online_order|
        all_online_orders << OnlineOrder.new(online_order[0], online_order[1], online_order[2], online_order[3])
      end
      #5. return an array of OnlineOrders
      return all_online_orders
    end

    #returns an instance of OnlineOrder where the value of the id field in
    #the CSV matches the passed parameter.
    def self.find(id)
      all_online_orders = Grocery::OnlineOrder.all
      all_online_orders.each do |one_online_order|
        if one_online_order.id == id
          return one_online_order
        end
      end
        raise ArgumentError.new("Order number #{id} could not be found.")
    end

    #returns a list of OnlineOrder instances where the value of the customer's ID matches the passed parameter.
    def self.find_by_customer(customer_id)
      one_customer_online_orders = []
      all_online_orders = Grocery::OnlineOrder.all
      all_online_orders.each do |one_online_order|
        if one_online_order.customer_id == customer_id
          one_customer_online_orders << one_online_order
        end
      end
      if one_customer_online_orders.length > 0
        return one_customer_online_orders
      else
        raise ArgumentError.new("Customer number #{customer_id} did not place an online_order.")
      end
    end

  end #end of class
end #end of module
