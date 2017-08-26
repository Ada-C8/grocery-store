# Each new OnlineOrder should include all attributes from the Order class as well as the following additional attributes:
#
# A customer object
# A fulfillment status (stored as a Symbol)
#
#pending, paid, processing, shipped or complete
#
# If no status is provided, it should set to pending as the default
# The OnlineOrder should include the following updated functionality:
#
# The total method should be the same, except it will add a $10 shipping fee

# The add_product method should be updated to permit a new product to be added ONLY if the status is either pending or paid (no other statuses permitted)
# Otherwise, it should raise an ArgumentError (Google this!)
# The OnlineOrder should also have the following class methods:
#
# self.all - returns a collection of OnlineOrder instances, representing all of the OnlineOrders described in the CSV. See below for the CSV file specifications
# Question Ask yourself, what is different about this all method versus the Order.all method? What is the same?
# self.find(id) - returns an instance of OnlineOrder where the value of the id field in the CSV matches the passed parameter. -Question Ask yourself, what is different about this find method versus the Order.find method?
# self.find_by_customer(customer_id) - returns a list of OnlineOrder instances where the value of the customer's ID matches the passed parameter.

require_relative 'order'
require 'csv'
require 'pry'

module Grocery
class OnlineOrder < Order
  attr_reader :customer_id
  attr_accessor :status
  def initialize(id, products, customer_id, status = :pending)
    super(id, products)
    @customer_id = customer_id
    @status = status.to_sym
  end

  def total
    super + 10 #adds $10 shipping fee
  end

  def add_product(product_name, product_price)
    # 
    # super(product_name, product_price)
    # unless Grocery::OnlineOrder.status == :pending
    #   raise ArgumentError.new("Due to order status, additional products can no longer be added to the order.")
    # end


  end

end

end
