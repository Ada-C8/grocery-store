module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
      @original_length = @products.length
      puts @products
    end

    def total
      #: implement total
      @total = 0
      @products.each do |product, price|
        @total += price + price*(0.075)
      end
      return @total.round(2)
    end

    def add_product(product_name, product_price)
      #  implement add_product
      @products.each do |product, price|
        if product == product_name
          return false
        end
      end
      @products[product_name] = product_price
      return true
    end

    def remove_product(product_name)
      @products.delete(product_name)
      if products.length == @original_length
        return false
      else
        return true
      end
    end
  end
end
