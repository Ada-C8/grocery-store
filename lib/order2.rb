module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      total = 0
      @products.length.times do |index|
        total += @products[index]["price"] * @products[index]["quantity"]
      end
      total += total * (7.50/100)
      total.round(2)
    end

    def add_product(product_info)
      found = false
      @products.each do |hash|
        hash.each do |label, info|
          if hash["name"] == product_info["name"]
            hash["quantity"] = product_info["quantity"]
            found = true
          else
          end
        end
      end
      if found == false
        @products << product_info
      end
    end

    def remove_product(product_name)
      found = false
      @products.each do |hash|
        hash.each do |label, info|
          if hash["name"] == product_name
            @products.delete(hash)
          end
        end
      end
      if found == false
        return false
      end
    end
  end
end
