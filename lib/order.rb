module Grocery
  class Order
    attr_reader :id, :products, :total

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      sum = 0
      @products.values.each do |price|
        sum += price
      end
      total = sum + (sum * 0.075).round(2)

    end

    def add_product(product_name, product_price)
      unless @products.has_key?(product_name)
        @products[product_name] = product_price
        return true
      else
        return false
      end
    end

def remove_product(product_name)
  if @products.has_key?(product_name)
    @products.delete(product_name)
    return true
  else
    return false
  end
end

  end
end

# order1 = Grocery::Order.new(3131, {"banana" => 1.50, "apple" => 3.00})
#
# puts order1.total
#
# puts order1.products.length
#
#
# order1.add_product("kiwi", 1.00)
#
# puts order1.products.length
#
#
# puts order1.total
#
# order1.remove_product("banana", 1.50)
#
# puts order1.products.length
