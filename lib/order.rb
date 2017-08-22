module Grocery
  class Order
    attr_reader :id, :products
    TAX = 0.075

    def initialize(id, products)
      @id = id
      @products = products
      @total = 0
    end

    def total
      # TODO: implement total
      pretax_total = 0

      @products.each do |product, price|
        pretax_total += price
      end

      @total = pretax_total + (pretax_total * TAX).round(2)

      return @total

    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
      unless @products.keys.include?(product_name)
        @products[product_name] = product_price
        return true
      end

      return false
    end

    def remove_product(product_name)
      if @products.keys.include?(product_name)
        @products.delete(product_name)
        return true
      end

      return false
    end

  end
end
