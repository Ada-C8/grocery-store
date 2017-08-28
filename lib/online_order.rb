require_relative 'order'
module Grocery
  class OnlineOrder < Order
    attr_reader :customer_id, :status

    @@online_orders = []

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
        return false
      when :pending, :paid
        super
        # else
        #   return "lalalala"
      end
    end

    def self.all
      # orders = []
      if @@online_orders.length > 0
        return @@online_orders
      end
      CSV.open("support/online_orders.csv", 'r').each do |line|
        id = line[0].to_i

        products_hash = {}
        products_arr = line[1].split';'
        products_arr.each do |item_colon_price|
          product_price = item_colon_price.split':'
          products_hash[product_price[0]] = product_price[1].to_f

        end
        customer_id = line[2].to_i
        status = line[3].to_sym

        @@online_orders << self.new(id, products_hash, customer_id, status)

      end
      return @@online_orders
    end


    def self.find(id_input)
      super

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





# - The `add_product` method should be updated to permit a new product to be added **ONLY** if the status is either pending or paid (no other statuses permitted)
#   - Otherwise, it should raise an `ArgumentError` (Google this!)



#   - `self.find(id)` - returns an instance of `OnlineOrder` where the value of the id field in the CSV matches the passed parameter.
#     -**Question** Ask yourself, what is different about this `find` method versus the `Order.find` method?
#   - `self.find_by_customer(customer_id)` - returns a **list** of `OnlineOrder` instances where the value of the customer's ID matches the passed parameter.
