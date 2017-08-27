require 'csv'
require_relative 'order'

class OnlineOrder < Order

  def initialize
    super
    @status = :status
    @customer = Customer.new
  end

  def total

  end

  def self.all
  end

  def self.find(id)
  end

  def self.find_by_customer(customer_id)
  end

end #end of class
