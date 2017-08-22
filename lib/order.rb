module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      total = 0

      products.each do |item, cost|
        total += cost
      end
      return total + (total * 0.075).round(2)
    end

    def add_product(product_name, product_price)

      if @products.has_key?(product_name)
        return false
      end

      products[product_name] = product_price

      if @products.include?(product_name)
        return true
      end
    end

  end #end of class
end #end of module
