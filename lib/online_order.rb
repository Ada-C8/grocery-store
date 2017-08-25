module Grocery

  require_relative 'order'

  class OnlineOrder < Order
    attr_reader :c_id, :status

    def initialize(id, products, customer_id, status)
      super(id, products)
      @c_id = customer_id
      @status = status
    end

    def total
      shipping = 10
      if @products.length != 0
        super + shipping
      else
        super
      end

    end
  end #OnlineOrder
end #module
