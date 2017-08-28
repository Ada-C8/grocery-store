module Grocery
  require 'csv'

  class Customer
    attr_accessor :id, :email, :address
    def initialize(id, email, address)
      @id = id.to_i
      @email = email
      @address = address
    end

  end # end of class
end # end of modeule
