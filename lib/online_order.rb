require_relative 'order'
module Grocery
  class OnlineOrder < Order
    attr_reader :customer_id, :status

    # @@online_orders = []

    def initialize(id, products, customer_id, status = :pending)
      super(id, products)
      @customer_id = customer_id
      @status = status.to_sym

    end

    def total
      if super == 0
        return 0
      else
        t = super + 10
        return t
      end
    end

    def add_product(product_name, product_price)
      #if the order status is processing, shipped, complete it won't do anything
      case @status
      when :processing, :shipped, :complete
        raise ArgumentError.new "Cannot add products to orders that are already paid for."
      when :pending, :paid
        super
        # else
        #   return "lalalala"
      end
    end

    def self.all
      online_orders = []
      # if @@online_orders.length > 0
      #   return @@online_orders
      # end
      CSV.open("support/online_orders.csv", 'r').each do |line|
        id = line[0].to_i
        products = product_split(line)
        customer_id = line[2].to_i
        status = line[3].to_sym

        online_orders << self.new(id, products, customer_id, status)

      end
      return online_orders
    end

    def self.find_by_customer(id_input)

      # orders = self.all
      counter = 0
      customers_orders = []
      self.all.each do |order|
        if order.customer_id == id_input
          counter += 1
          customers_orders << order
        end
      end
      if counter == 0
        raise ArgumentError.new("Invalid Customer ID")
      end
      return customers_orders
    end

    def customer
      customer = Grocery::Customer.find(@customer_id)
      return customer
    end
  end
end






#   - `self.find(id)` - returns an instance of `OnlineOrder` where the value of the id field in the CSV matches the passed parameter.
#     -**Question** Ask yourself, what is different about this `find` method versus the `Order.find` method?
#   - `self.find_by_customer(customer_id)` - returns a **list** of `OnlineOrder` instances where the value of the customer's ID matches the passed parameter.
