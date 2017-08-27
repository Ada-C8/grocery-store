require 'csv'
require 'order'
require 'customer'
module Grocery
  class OnlineOrder < Order
    attr_reader :customer, :status

  def initialize(id, products, customer, status = :pending)
    super id,  products
    @customer = customer
    @status = status
  end

























  end
end
