require_relative 'order'
require 'csv'

class OnlineOrder < Grocery::Order
  attr_reader :customer, :status, :products, :id

  def initialize(products, id, customer, status)
    super(products, id)
    @customer = customer
    @status = status
  end

  def total
    # return super + 10.00
    # The total method should be the same, except it will add a $10 shipping fee
  end

  def add_total
    # should be updated to permit a new product to be added ONLY if the status is either pending or paid (no other statuses permitted)
    # Otherwise, it should raise an ArgumentError (Google this!)
  end

  def self.all
    # CSV.open("support/online_orders.csv", 'r').each do |line|
    #   line[0]

    # returns a collection of OnlineOrder instances, representing all of the OnlineOrders described in the CSV. See below for the CSV file specifications
    # Question Ask yourself, what is different about this all method versus the Order.all method? What is the same?
    # order_id
    #
    # current_customer = G::Customer.find(customer_id)
    # current_order_status = status_id
    # OnlineOrder.new(current_customer, current_order_status
  end
  def self.find(id)
    # returns an instance of OnlineOrder where the value of the id field in the CSV matches the passed parameter. -Question Ask yourself, what is different about this find method versus the Order.find method?
  end
  def self.find_by_customer(customer_id)
    #returns a list of OnlineOrder instances where the value of the customer's ID matches the passed parameter.
  end


end # CLASS
