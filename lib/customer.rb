require 'csv'

module Grocery
  class Customer
    attr_reader :id, :email, :delivery_address, :all_info

    def initialize(id, email, delivery_address)
      @id = id
      @email = email
      @delivery_address = delivery_address
      @all_info = "The new customer has an id of #{@id}, email: #{@email}, and their address is #{@delivery_address}."
    end

    def print_info(array)
      array.each do |line|
        puts "Customer ID is #{@id}"
        puts "Customer email is #{@email}"
        puts "Customer address is #{@delivery_address}"
      end
      # return "Id: #{@id} has email #{@email} and their address is #{@address}."
    end


    def self.all
      all_customers = []

#I was struggling to call the individual values in this array; originally
#I did not label them as instance variables and it would just give me the
#place in memory but not the actual value -- is that because the local variables
#disappear and even though they are passed through the customer class initiation
#they have to be called as instance variables??
      CSV.open("support/customers.csv", "r").each do |line|
        @id = line[0]
        # puts "This is the id #{@id}"
        @email = line[1]
        # puts "This is the email #{@email}"
        @delivery_address = line[2..5]
        # puts "this is the delivery address : #{@delivery_address}"
        new_customer = Customer.new(@id, @email, @delivery_address)
        all_customers << new_customer
      end
      puts "length is : #{all_customers.length}"
      all_customers.length.times do |customer|
        puts line.all_info
        # puts "Customer ID: #{@id} **** Customer email:#{@email}"
        # puts "Customer address is #{@delivery_address}"
      end
#self.all end
    end


#class end
  end
#module end
end


frenchie = Grocery::Customer.all
