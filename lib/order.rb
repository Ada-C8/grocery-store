module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      total = 0
      @products.each do |product|
        total += product[1]
      end
      total = (total * 1.075).round(2)
      return total
    end

    # def add_product(product_name, product_price)
    #   unless @products.has_key?(product_name)
    #     @products[product_name] = product_price
    #     return true
    #   else
    #     return false
    #   end
    # end
  end
end
