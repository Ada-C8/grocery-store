require_relative './order'

class OnlineOrder < Grocery::Order
  attr_reader :customer, :status

  def initialize(csv_line)
    super
    @customer = Grocery::Customer.find(csv_line[2].to_i)
    if csv_line[3] == ""
      @status = :pending
    else
      @status = csv_line[3].to_sym
    end
  end

  def total
    return 0 if @products.length == 0
    shipping_total = (@products.values.sum * 1.075).round(2) + 10
    return shipping_total
  end

  def add_product(product_name, product_price)
    raise ArgumentError.new("The order status must be paid or pending") unless [:paid, :pending].include?(self.status)
    if @products.keys.include?(product_name)
      return false
    else
      @products[product_name] = product_price
      return true
    end
  end

  def self.find_by_customer(number)
    customer_orders = @@orders.size.times.select {|i| @@orders[i].customer.id == number}
    return customer_orders
  end

end
