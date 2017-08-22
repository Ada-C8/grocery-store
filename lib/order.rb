module Grocery
  class Order

    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      total = 0
      @products.values.each do |price|
        total += price
      end
      total += (0.075 * total).round(2)
    end

    def add_product(product_name, product_price)
      new_product = { product_name => product_price }
      exists_in_products = false
      @products.has_key?(product_name) ? exists_in_products = false : exists_in_products = true
      @products.merge!(new_product) { |key, old_value, new_value| old_value }
      return exists_in_products
    end

    def remove_product(product_name)
      deleted_value = @products.delete(product_name)
      if deleted_value == nil
        return false
      else
        return true
      end
    end

  end
end
