require 'csv'
require 'awesome_print'
require 'pry'

require_relative 'order'
require_relative 'customer'

module Grocery
  class OnlineOrder < Order
  # The OnlineOrder class will inherit behavior from the Order class and include additional data to track the customer and order status.
    attr_reader :id, :products, :customer, :order_status

    def initialize(id, products, customer_id, order_status = :pending)
      @id = id
      @products = products
      @customer = Grocery::Customer.find(customer_id)
      @order_status = order_status
    end

    def total
      if super > 0
        total = super + 10
        return total
      end
      #else
        #raise ArgumentError.new("Your order is empty so we cannot add shipping!")
    end

    def add_product(product_name, product_price)
    # The add_product method should be updated to permit a new product to be added ONLY if the status is either pending or paid (no other statuses permitted)
    #acceptable_status = [:pending, :paid]
      if @order_status = :pending || @order_status = :paid
        if @products.keys.include?(product_name)
          return false
        else
          @products[product_name] = product_price
          return true
        end
      else
        raise ArgumentError.new("You can only add products to the order if the status is pending or paid.")
      end
    end

    def self.all
      orders_array = []
      CSV.read('./support/online_orders.csv').each do |row|
        products_hash = {}
        products_colon = row[1].split(";")
        products_colon.each do |e|
          k = e.split(":").first
          v = e.split(":").last
          products_hash.merge!({k => v.to_i})
        end
        orders_array << Grocery::OnlineOrder.new(row[0], products_hash, row[2], row[3])
      end
      return orders_array
    end

    def self.find(order_id)
      # returns an instance of OnlineOrder where the value of the id field in the CSV matches the passed parameter. -Question Ask yourself, what is different about this find method versus the Order.find method?
      #this returns only one piece of data- the order at that order id. It will return the whole object, not just the array of products.
      ordered_stuff = []
      #if id > 1 && id <@orders_array.length
      all_online_orders = Grocery::OnlineOrder.all
      all_online_orders.each do |order|
        if order.id == order_id
          ordered_stuff << order
        end
      end
      if ordered_stuff.empty?
        raise ArgumentError.new("You did not enter a valid order number.")
      end
      return ordered_stuff
    end

    def self.find_by_customer(customer_id)
      # returns a list of OnlineOrder instances where the value of the customer's ID matches the passed parameter.
      #i.e. return ALL orders made by a specific customer- need to store them in an array
      #it will return an array of objects, not just a products array
      orders_by_customer_x = []
      all_online_orders = Grocery::OnlineOrder.all
      all_online_orders.each do |order|
          if order.customer.id == customer_id
            orders_by_customer_x << order
          end #end if
      end #end do order
      if orders_by_customer_x.empty?
        raise ArgumentError.new("You did not enter a valid customer ID or that customer does not have any online orders.")
      end
      return orders_by_customer_x
    end

  end #end of class OnlineOrder
end #end of module

Grocery::OnlineOrder.all


# grocery = Grocery::OnlineOrder.all
# puts "DOES THIS A ONLINE ORDER CLASS OUTPUT AN ARRAY?"
# ap grocery.class

#grocery = Grocery::OnlineOrder.all
#puts "TESTING FIND (BY ORDER ID):"
#ap Grocery::OnlineOrder.find("10")

#puts "TESTING FIND BY CUSTOMER METHOD:"
# Customer 6 has 3 online orders
#ap Grocery::OnlineOrder.find_by_customer("6")
