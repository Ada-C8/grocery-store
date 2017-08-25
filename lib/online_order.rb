require_relative 'Order'

module Grocery
  attr_reader :customer_id, :status
  class OnlineOrder < Order
    def initialize(id, products, customer_id, status)
      super(id, products)
      @customer_id = customer_id
      @status = status
    end #initialize

    #I had to make this method cause the attr_reader didn't work. Why is that??
    def customer_id
      return @customer_id
    end #customer_id

    #I had to make this method cause the attr didn't work (same at for customer_id). Why??
    def status
      return @status
    end #status

    def total
      if super == 0
        return 0
      else
        return super + 10
      end #if/else
    end #total

    def add_product(products, price)
      if @status == "processing" || @status == "shipped" || @status == "completed"
        raise ArgumentError.new("Error: you cannot add to you order because it is allready #{@status}")
      else
        super
      end #if/else
    end #add_product

  end #OnlineOrder
end #Grocery

online_order = Grocery::OnlineOrder.new("3", {apple: 2, pear: 3}, "1", "Paid")
puts online_order.customer_id
# 1,Lobster:17.18;Annatto seed:58.38;Camomile:83.21,25,complete
