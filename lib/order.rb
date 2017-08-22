require 'csv'


module Grocery

  class Order
    attr_reader :id, :products

    @@orders = []

    def initialize(csv_line)
      @id = csv_line[0].to_i
      products_array = csv_line[1].split(";")
      @products= Hash.new(0)
      products_array.each do |product|
        name_price = product.split(":")
        @products[name_price[0]] = name_price[1].to_f
      end
      @@orders.push(self)
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
      if @products.keys.include?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

    def self.all
      return @@orders
    end

    def self.find(number)
      @@orders.each do |order|
        return order if order.id == number
      end
      raise ArgumentError.new("This order id does not exist")
    end

  end # class Order

  def self.read(filename)
    lines = CSV.open(filename, 'r').read
    lines.each do |line|
      Order.new(line)
    end
  end

end # module Grocery

Grocery::read(File.expand_path('../..', __FILE__) + '/support/orders.csv')
