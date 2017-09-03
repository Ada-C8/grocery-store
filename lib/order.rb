module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end
#total method summs up products + 7.5% tax, rounded
    def total
      added_products = 0
      @products.each_value do |cost|
        added_products += cost
      end
      total = (added_products + (added_products * 0.075)).round(2)
      return total
    end
#return true if products includes product, false if not
    def add_product(product_name, product_price)

      if @produts.keys.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end

    end




  end #(class)
end #(module)
