module Grocery
  class Customer
    attr_reader :id, :email, :address_info
    def initialize(input_id, input_email, input_address_info)
      @id = input_id
      @email = input_email
      @address_info = input_address_info
    end
    def self.all
    end
    def self.find(input_id)
    end
  end
end
