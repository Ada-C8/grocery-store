require_relative 'order'
require 'csv'

# inherit behavior from the Order class and include additional data to track the customer and order status.
module Grocery
  class OnlineOrder < Grocery::Order
  end

  def total
    # The total method should be the same, except it will add a $10 shipping fee
  end

  def add_product
    # the add_product method should be updated to permit a new product to be added ONLY if the status is either pending or paid (no other statuses permitted) - Otherwise, it should raise an ArgumentError
  end

  def self.all
    #  returns a collection of OnlineOrder instances, representing all of the OnlineOrders described in the CSV. See below for the CSV file specifications
    # Question Ask yourself, what is different about this all method versus the Order.all method? What is the same?
  end

  def self.find(id)
    # returns an instance of OnlineOrder where the value of the id field in the CSV matches the passed parameter. -Question Ask yourself, what is different about this find method versus the Order.find method?
  end

  def self.find_by_customer(customer_id)
    #  returns a list of OnlineOrder instances where the value of the customer's ID matches the passed parameter.
  end
end
