require_relative 'order'
require_relative 'customer'
module Grocery
  class OnlineOrder < Order
    attr_reader :id, :products, :customer, :status
    def initialize(id, products = 0, customer_id, status)
      @id = id
      @products = products
      @customer = Grocery::Customer.find(customer_id)
      # @customer = customer_id
      @status = status
    end
    def total
      if @products != 0
        super + 10
      else 0
      end
    end
    def add_product(product_name, product_price)
      case @status
      when :pending, :paid
        super
      when :complete, :shipped, :processing
        raise ArgumentError.new "Cannot add prodcut to complete, shipped or processing online orders"
      end
    end

  end
end
