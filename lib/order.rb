module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      # TODO: implement total
      if products.length == 0
        total = 0
        return total
      else
        sum = products.values.inject(0, :+)
        total = sum + (sum * 0.075).round(2)
        return total
      end
    end

    def add_product(product_name, product_price)
      if @products.include? product_name
        return false
      else
        @products.merge!(product_name => product_price)
        return true
      end
    end

    def remove_product(product_name)
      if @products.include? product_name
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

  end
end
