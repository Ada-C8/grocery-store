require 'csv'
require_relative 'customer'
require_relative 'order'

module Grocery

  class OnlineOrder < Grocery::Order

    attr_reader :customer, :status

    def initialize(id, products, customer, status = :pending)
      @id = id #id: int, products: {item: price}
      @products = products
      @customer = customer #Customer object
      @status = status
    end

    def total
      total = super
      #no products/empty hash
      total != 0 ? total += 10 : total = 0
    end

    def add_product(product_name, product_price)
      if @status == :pending || @status == :paid
        new_product = { product_name => product_price }
        can_successfully_add = false
        @products.has_key?(product_name) ? can_successfully_add = false : can_successfully_add = true
        if can_successfully_add
          @products.merge!(new_product) { |key, old_value, new_value| old_value }
        end
        return can_successfully_add
      end
      raise ArgumentError.new("Status is neither pending nor paid")
    end
  end
end
