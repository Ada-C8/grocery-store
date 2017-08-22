module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      raise ArgumentError.new("The order id must be an integer") if id.class != Integer
      @id = id
      @products = products
    end

    def total
      tax_total = (@products.values.sum * 1.075).round(2)
      return tax_total
    end

    def add_product(product_name, product_price)
      if @products.keys.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)

    end
  end # class Order
end # module Grocery
