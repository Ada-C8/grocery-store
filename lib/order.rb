module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      without_taxes = 0
      # TODO: implement total
      @products.each do |product, value|
        without_taxes += value
      end
      total_price = without_taxes +( without_taxes * 0.075)
      return total_price.round(2)
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
      if @products.key?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def delete_product(product_name)
      if @products.key?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

    def see
      return @products
    end
  end
end

products = {cream: 2.34, soup: 1.50, water: 2.25 }
id = 4


example = Grocery::Order.new(id,products)
example.delete_product(:soup)
puts example.see
