require 'csv'
require 'awesome_print'
require_relative 'order'

=begin
OnlineOrder

(Online order will inherit behaviour from the Order class)

(OnlineOrder Attributes):
- Customer object (instance of Customer)
- An online order fulfillment status (stored as a Symbol):
* :pending, :paid, :processing, :shipped or :complete
* If no status is provided, it should set to pending as the default

(OnlineOrder Updated Functionality (Methods):

-The total method should be the same, but adds a $10 shipping fee
-The add_product method allows a new product to be added ONLY if the online order status is either :pending or :paid (no other statuses permitted); Otherwise, it should raise an ArgumentError

OnlineOrder Class Methods:
-self.all - returns a collection of OnlineOrder instances, representing all of the OnlineOrders described in the CSV.

-self.find(id) - returns an instance of OnlineOrder where the value of the id field in the CSV matches the passed parameter.

-self.find_by_customer(customer) - returns a list of OnlineOrder instances where the value of the customer's ID matches the passed parameter.

=end

require_relative 'customer'

module Grocery

  class OnlineOrder < Order

    attr_reader :online_id, :products, :customer, :status

    def initialize(online_id, products, customer, status = :pending) #Argument default notation: http://ruby-doc.com/docs/ProgrammingRuby/html/tut_methods.html (Error arises if notation is status: :complete; notation from github: https://docs.google.com/document/d/1Jtb8Pz6QZuktP48bdFiLvsx-UCSyXZ_COWeEX4Ftcxs/edit)
      @online_id = online_id
      @products = products #a collection of products and their cost -> products = {product_name: cost}
      @customer = Grocery::Customer.find(customer) #passing a customer object; an instance of customer from customer.rb
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
      online_orders = CSV.read('support/online_orders.csv', converters: :numeric)
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
      orders = Grocery::Order.all

      orders.each do |element|
        if element.id == id
          return element
        end
      end
      raise ArgumentError.new("ORDER ##{id} NOT FOUND!")
    end
  end#of_OnlineOrder_class

end#of_Grocery_module
