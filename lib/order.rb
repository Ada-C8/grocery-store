module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      @sum = @products.values.inject(0, :+)
      @total = @sum + (@sum * 0.075).round(2)
    end

    def add_product(product_name, product_price)
      if @products.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true #Why do we want to return true here?
      end
    end

    def remove_product(product_name, product_price)
      unless @products.include?(product_name)
        return false
      end
      @products.delete(product_name)
      return true
    end
  end
end
