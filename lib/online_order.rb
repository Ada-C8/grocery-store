require 'csv'

module Grocery
  class OnlineOrder < Grocery::Order
    attr_reader :customer_id, :status

    def initialize(id, products, customer_id, status = :pending)
      super(id, products)
      @customer_id = Grocery::Customer.find(customer_id)
      @status = status
    end

    def total
      if @products.empty?
        total = 0
      else
        total = super + 10
      end
      return total
    end

    def add_product(product_name, product_price)

      if @status != :paid && @status != :pending
        raise ArgumentError.new "Cannot add a new product at this time."
      else
        return super
      end
    end

  end #end of online_order

end # end of grocery
