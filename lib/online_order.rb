#include Grocery
require_relative 'order'
require_relative 'customer'

class OnlineOrder < Grocery::Order

  @@all_online_orders = Array.new
  @@status_array = [:pending, :paid, :processing, :shipped, :complete]

  attr_reader :customer_info, :status

  def initialize(id, products, customer_info, status)
    super(id, products)
    @customer_info = customer_info
    if @@status_array.include?(status.to_sym)
      @status = status.to_sym
    else @status = :pending
    end
  end #init

  def total
    if products == {}
      return @total = 0
    else
      @total = super + 10.00
    end
    return @total
  end #total method

  def self.all
    products = {}
    @@all_online_orders = []
    CSV.open('../support/online_orders.csv', 'r').each do |line|
      id = line[0].to_i #assign ids
      customer_id = line[2].to_i
      status = line[3].to_sym
      semi_colon_split = line[1].split(';') #split out products by dividing by semi colons
      semi_colon_split.each do |item|
        colon_split = item.split(":") #split prices from products
        semi_colon_split.length.times do
          products[colon_split[0]] = colon_split[1] #assign prices to products in the products hash
        end # length.times do
      end #of x.each do
      @@all_online_orders << OnlineOrder.new(id, products, Grocery::Customer.find(customer_id), status)
      products = {}
    end #
    return @@all_online_orders
  end #all method

  def self.find(id)
      orders = OnlineOrder.all
      item_num = []

      orders.each do |item|
        item_num << item.id
      end

      if item_num.include?(id)
        return orders[id - 1]
      else
        raise ArgumentError
      end
  end

  def self.find_by_customer(cust_id)
    orders = OnlineOrder.all
    customer_orders = []

    orders.each do |item|
      if item.customer_info.customer_id == cust_id
        customer_orders << item
      end #if statement
    end #each do
    return customer_orders
  end #end find by customer
  # if item_num.include(customer_info.customer_id)

    #returns an array of online orders for specific customer ID  - returns a list of OnlineOrder instances where the value of the customer's ID matches the passed parameter.


  def add_product(product_name, product_price)
    if @status == :paid || @status == :pending
      super(product_name, product_price)
    else
      raise ArgumentError
    end #if statment
  end #add_product
end #class



puts OnlineOrder.find_by_customer(1).inspect
# puts OnlineOrder.find(1).customer_info.customer_id
# puts OnlineOrder.find(100).customer_info.customer_id
# puts OnlineOrder.find(1900).inspect
#
# j = OnlineOrder.all
# j.each do |order|
#   puts "#{order.customer_info.customer_id}"
#
#   # puts "Order Status #{order.status}"
#   # puts "Customer is #{j.customer_info} and it is class #{j.customer_info.class}"
# end
  # puts "Order Id: #{order.id}. \nProducts: #{order.products}. \nCustomer Info: ID:  #{order.customer_info.customer_id}, email: #{order.customer_info.email}, Address: #{order.customer_info.delivery_address}."

# x = OnlineOrder.new(19, {cheese:5.00, bacon:5.00}, Grocery::Customer.new(12, "amy@this.com", "123 Fake St., Dayton, Ohio, 12121"), :paid)
# puts x.add_product("chicken", 10.00)
# puts x.products
#
# puts "status is #{x.status} and it class #{x.status.class}"


# A customer object
# A fulfillment status (stored as a Symbol)
# pending, paid, processing, shipped or complete
# If no status is provided, it should set to pending as the default
