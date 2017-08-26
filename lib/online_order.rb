require 'csv'
###??? Do we need to reference the order class for it to work?

module Grocery

###??? Is this enought to inherit behavior? Does it change the way things need to be called?

  class OnlineOrder < Order
    attr_reader super, :customer_id, :status
    ## additional attributes (does that mean the arguments we pass in initialize?)
      #customer object
      #fulfillment status (SYMBOL)
        #pending, paid, shipped/complete
        #if no status, default - pending

    def initialize(id, products, customer_id, status = pending )
##??? does the location of the super matter? Is it like return,
## where it needs to be added at the bottom?
      super
      @customer_id = customer_id
      @status = status.to_sym
      #might need a customer class initiated?
    end #intialize end

    # add product updated to permit new product to be added ONLY if status is pending or paid
    #otherwise, raise argument error
    def add_product(product_name, product_price)
      unless @status == :shipped
        self
      else
        #raise argument error "Cannot add order; Order has already shipped"
      end
    end #add_product end


    def total
      super
      # $10 shipping fee
      oo_total = expected_total + 10
      return oo_total
    end #total end

    # collection of OnlineOrder instances - all OO described in CSV
    # what is the same from the order.all method? what's the diff?
    #need to store status as symbol
    def self.all

    end #self.all end

    #instance of OO where value in id field matches CSV parameter
    # what is different about this find method vs order.find method?
    def self.find(id)

    end

    # returns a list of online order instances where cust. id matches passed parameter
    def self.find_by_customer(customer_id)
    end

  end #order end

end #module end
