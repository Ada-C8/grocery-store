require_relative 'order'
module Grocery
  class OnlineOrder < Order
    attr_reader  :status, :customer

    def initialize(id, products, customer, status: :pending)
      # - A customer object
      # - A fulfillment status (stored as a **Symbol**)
      #   - pending, paid, processing, shipped or complete
      #   - If no status is provided, it should set to pending as the default
      super(id, products)
      if ![:pending, :paid, :processing, :shipped, :completed].include? status
        raise ArgumentError.new "Not a valid status"
      end
      if customer.class != Grocery::Customer
        raise ArgumentError.new "Not a customer object"
      end
      @customer = customer
      @status = status
    end

    def total
      if @products.keys.length > 0
        return super + 10
      else
        return super
      end
    end

    def add_product(product_name, product_price)
      if @status == :pending || @status == :paid
        super(product_name, product_price)
      else
        raise ArgumentError.new "Your order does not have the right status"
      end
    end

    def self.all(customers, csv_file)
       super(csv_file)
       csv_file.each do |line|
         customer = customers.find(i)
         @@array_of_onlineorders = self.new(self.array_of_orders[i].id, self.array_of_orders[i].products,customer,status)
       end
    end

    def self.find()

    end

  end # end class
end #end module
