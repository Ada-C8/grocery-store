require 'csv'
require_relative 'order'
require_relative 'customer'
# A customer object
# A fulfillment status (stored as a Symbol)
# pending, paid, processing, shipped or complete
# If no status is provided, it should set to pending as the default

class OnlineOrder < Grocery::Order
  attr_reader :customer, :status, :id, :products
  def initialize(id, products, customer, status) #paid, processing, shipped, complete status: "pending"
    # super HOW TO DO THIS? Does not seem to be getting @id and @products from Order
    @id = id
    @products = products
    @customer = customer
    @status = status.to_sym
  end

  # The total method should be the same, except it will add a $10 shipping fee
  def total
    return super + 10
  end

  # The add_product method should be updated to permit a new product to be added ONLY if the status is either pending or paid (no other statuses permitted)
  # Otherwise, it should raise an ArgumentError (Google this!)
  def add_product
    unless @status != :pending || @status != :paid
      raise ArgumentError.new("You can't add a product unless your status is pending or paid")
    end
    return super
  end

  # self.all - returns a collection of OnlineOrder instances, representing all of the OnlineOrders described in the CSV. See below for the CSV file specifications
  def self.all(file) #call with file = 'support/online_orders.csv'
    all_orders = super #returns an array of all_orders instances from Order (which have @id and @products)
    # puts "ALL ORDERS: #{all_orders}"
    # puts "#{all_orders[0].id}"
    # puts "#{all_orders[0].products}"
    csv_file = (CSV.open(file, 'r'))
    customer_id = nil
    status = nil
    all_online_orders = []
    order_id = nil
    order_products = nil

    csv_file.each do |line|
      customer_id = line[2].to_i
      puts "CUSTOMER ID: #{customer_id}"
      status = line[3].to_sym

    all_orders.each do |order|
      order_id = order.id
      order_products = order.products
      puts "PRODUCTS: #{order_products}"
      online_order = OnlineOrder.new(order_id, order_products, customer_id, status)
      all_online_orders << online_order
    end
    end
    # return all_online_orders
      # puts "YAY?: #{all_online_orders[0].id}"
    puts "LENGTH: #{all_online_orders.length}"
  end


end
# puts OnlineOrder.all('support/online_orders.csv')[0].products
OnlineOrder.all('support/online_orders.csv')

#     id = nil
#     products_arr = []
#     products = {}
#     customer_id = nil
#     status = nil
#     all_online_orders = []
#
#     csv_file = (CSV.open(file, 'r'))
#
#     csv_file.each do |line|
#       id = line[0].to_i
#       customer_id = line[2].to_i
#       status = line[3].to_sym
#       products_arr = line[1].split(';')
#       products = Hash[products_arr.map { |i| i.split(":") }]
#       products = Hash[products.keys.zip(products.values.map(&:to_f))]
#       # Hash[h.map {|k, v| [k, v.to_f] }]
#       order = OnlineOrder.new(id, products, customer_id, status)
#       all_online_orders << order
#     end
#     return all_online_orders
#   end
# end
  # Question Ask yourself, what is different about this all method versus the Order.all method? What is the same?
  # self.find(id) - returns an instance of OnlineOrder where the value of the id field in the CSV matches the passed parameter. -Question Ask yourself, what is different about this find method versus the Order.find method?
  # self.find_by_customer(customer_id) - returns a list of OnlineOrder instances where the value of the customer's ID matches the passed parameter.
#OnlineOrder
