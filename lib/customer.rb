
module Grocery
  class Customer
    attr_reader :customer_id, :email, :address

    def initialize(customer_id, email, address)
      @customer_id = customer_id
      @email = email
      @address = address
    end

  end #end of class

end #end of module
