require "customer"

class OnlineOrder
  self < Order
  attr_accessor :fulfillment_status

  def initialize(fulfillment_status = 0)
  end

  # def self.total
  # Customer.total + 10
  # end

  #return collection of OnlineOrder instances
  def self.all
  end

  #return list of OnlineOrder instance
  def self.find(id)
  end

  #return list of onlineorder instances
  def self.find_by_customer(customer_id)
  end
end
