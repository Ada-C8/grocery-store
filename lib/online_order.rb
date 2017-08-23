require_relative './order'

class OnlineOrder < Grocery::Order
  attr_reader :customer, :status

  def initialize(csv_line)
    super
    @customer = Grocery::Customer.find(csv_line[2].to_i)
    @status = csv_line[3]
  end

  def total
    return 0 if @products.length == 0
    shipping_total = (@products.values.sum * 1.075).round(2) + 10
    return shipping_total
  end

  def self.find_by_customer(number)
    customer_orders = @@orders.size.times.select {|i| @@orders[i].customer.id == number}
    if customer_orders.length == 0
      raise ArgumentError.new("This customer hasn't placed any orders")
    else
      str = "Customer #{number} ordered:\n"
      customer_orders.each do |index|
        str += "Online Order ID: #{@@orders[index].id}\n"
      end
    end
    return str
  end

end

# Grocery::Customer.read(File.expand_path('../..', __FILE__) + "/support/customers.csv")
#
# OnlineOrder.read(File.expand_path('../..', __FILE__) + '/support/online_orders.csv')
