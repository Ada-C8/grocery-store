require 'csv'
require_relative 'order'
require_relative 'customer'
# A customer object
# A fulfillment status (stored as a Symbol)
# pending, paid, processing, shipped or complete
# If no status is provided, it should set to pending as the default

class OnlineOrder < Grocery::Order
  attr_reader :customer, :status
  def initialize(status: "pending") #paid, processing, shipped, complete
    super
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
  def self.all(file)
    super
    # id = nil
    # status = nil
    # customer_id = nil
    # products_arr = []
    # products = {}
    # all_online_orders = []

    # CSV.open('support/online_orders.csv', 'r').each do |line|
    #   id = line[0].to_i
    #   customer_id = line[2].to_i
    #   status = line[3].to_sym
    #   products_arr = line[1].split(';')
    #   products = Hash[products_arr.map { |i| i.split(":") }]
    #   products = Hash[products.keys.zip(products.values.map(&:to_f))]
    #   # Hash[h.map {|k, v| [k, v.to_f] }]
    #   order = OnlineOrder.new(id, products, customer_id, status)
    #   all_online_orders << order
    # end
    # return all_online_orders
  end
end
  # Question Ask yourself, what is different about this all method versus the Order.all method? What is the same?
  # self.find(id) - returns an instance of OnlineOrder where the value of the id field in the CSV matches the passed parameter. -Question Ask yourself, what is different about this find method versus the Order.find method?
  # self.find_by_customer(customer_id) - returns a list of OnlineOrder instances where the value of the customer's ID matches the passed parameter.
#OnlineOrder

puts OnlineOrder.all('support/online_orders.csv')[0].products
