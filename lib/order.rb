module Grocery
  TAX = 0.075
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      if @products.length == 0
        return 0
      else
        return (@products.values.inject(:+) * (1 + TAX)).round(2)
      end
    end

    def add_product(product_name, product_price)
      if @products.keys.include?(product_name)
        return false
      else
        @products.merge!({product_name => product_price})
        return true
      end
    end

    def remove_product(product_name)
      if @products.include?(product_name)
        @products.delete(product_name)
        return true
      end
    end
  end
end
