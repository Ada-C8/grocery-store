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



  end # end class
end #end module
