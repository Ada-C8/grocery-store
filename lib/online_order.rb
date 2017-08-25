require_relative 'order'
module Grocery
  class OnlineOrder < Order
    attr_reader :customer_id, :status

    def initialize(id, products, customer_id, status)
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

    def self.all
      # orders = []
      if @@orders.length > 0
        return @@orders
      end
      CSV.open("support/orders.csv", 'r').each do |line|
        id = line[0].to_i
        # line[1] = line[1].split(';')
        # line[1] = line[1].gsub!':' '=>'
        # products = line[1].to_h
        # products = line[1]
        products_hash = {}
        products_arr = line[1].split';'
        products_arr.each do |item_colon_price|
          product_price = item_colon_price.split':'
          products_hash[product_price[0]] = product_price[1].to_f

        end

        @@orders << self.new(id, products_hash)

      end
      return @@orders
    end

    def self.find(id)
      super
      # # customers = self.all
      # # logic error:
      # until (1..@@customers.length).include?(id) #&& (id.kind_of? Integer)
      #   raise ArgumentError.new("Invalid id: #{id}")
      # end
      #
      # found_customer = nil
      # @@customers.each do |customer|
      #   if customer.id == id
      #     found_customer = customer
      #   end
      # end
      # return found_customer
    end

    def customer(customer_id)
      customer = Grocery::Customer.find(customer_id)
      return customer
    end
  end
end





# Each new OnlineOrder should include all attributes from the `Order` class as well as the following **additional** attributes:
# - A customer object
# - A fulfillment status (stored as a **Symbol**)
#   - pending, paid, processing, shipped or complete
#   - If no status is provided, it should set to pending as the default
#
# The OnlineOrder should include the following updated functionality:
# - The `total` method should be the same, except it will add a $10 shipping fee
# - The `add_product` method should be updated to permit a new product to be added **ONLY** if the status is either pending or paid (no other statuses permitted)
#   - Otherwise, it should raise an `ArgumentError` (Google this!)
#
# The OnlineOrder should also have the following **class** methods:
#   - `self.all` - returns a collection of `OnlineOrder` instances, representing all of the OnlineOrders described in the CSV. See below for the CSV file specifications
#     - **Question** Ask yourself, what is different about this `all` method versus the `Order.all` method? What is the same?
#   - `self.find(id)` - returns an instance of `OnlineOrder` where the value of the id field in the CSV matches the passed parameter.
#     -**Question** Ask yourself, what is different about this `find` method versus the `Order.find` method?
#   - `self.find_by_customer(customer_id)` - returns a **list** of `OnlineOrder` instances where the value of the customer's ID matches the passed parameter.
