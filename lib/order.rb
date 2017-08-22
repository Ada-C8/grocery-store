module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      sum = 0
      @products.each_value do |price|
        sum += price
      end
      (sum * 1.075).round(2)
    end

    def add_product(product_name, product_price)
      if @products[product_name] == nil
        @products.store(product_name, product_price)
        return true
      else
        return false
      end
    end

    def remove_product(product_name)
      if @products[product_name] == nil
        return false
      else
        @products.delete(product_name)
        return true
      end
    end
  end
end
