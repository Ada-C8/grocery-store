require 'csv'

module Grocery
  class Customer
    attr_reader :id, :email, :delivery_address, :all_info, :customer_information

    def initialize(id, email, delivery_address)
      @id = id.to_i
      @email = email
      @delivery_address = delivery_address
      ### Is it necessary to add this customer information component here? Do I need
      ### to store this in an array? Can it be called as a whole without doing that?
      @customer_information = [@id, @email, @delivery_address]
      @all_info = "The new customer has an id of #{@id}, email: #{@email}, and their address is #{@delivery_address}."
    end

    def print_info
      # array.each do |line|
      puts "Customer ID is #{@id}"
      puts "Customer email is #{@email}"
      puts "Customer address is #{@delivery_address}"
      # end
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
        id = line[0].to_i
        # puts "This is the id #{@id}"
        email = line[1]
        # puts "This is the email #{@email}"
        delivery_address = line[2..5]
        # puts "this is the delivery address : #{@delivery_address}"
        new_customer = Customer.new(id, email, delivery_address)
        all_customers << new_customer
      end
      # puts "length is : #{all_customers.length}"

      return all_customers
      # I tried to make it return here, but it wasn't working the way I expected
      # all_customers.length.times do |customer|
      # puts line.all_info
      # puts "Customer ID: #{@id} **** Customer email:#{@email}"
      # puts "Customer address is #{@delivery_address}"

    end #self.all end

    def self.find(customer_num)
      ## multiple ways to acquire the same information - comes down to user desing
      ## do we want to be able to input a number or do we want to write it out in the
      ## code at the bottom or as an argument in the class method

      # puts "Enter the ID of the customer you are looking for."
      # customer_num = gets.chomp.to_i

      new_customer = nil
      customer_id_array = []
### think about how to include the self.all method to DRY code and not run through the CSV twice


      CSV.open("support/customers.csv", "r").each do |line|
        id = line[0].to_i
        customer_id_array << id
      end

      if customer_id_array.include?(customer_num)
        CSV.open("support/customers.csv", "r").each do |line|
          if line[0].to_i == customer_num
            id = line[0].to_i
            # puts "This is the id #{@id}"
            email = line[1]
            # puts "This is the email #{@email}"
            delivery_address = line[2..5]
            # puts "this is the delivery address : #{@delivery_address}"
            return new_customer = Customer.new(id, email, delivery_address)
            # puts "Customer information"
            # return new_customer.print_info
          end
        end
      else
        return raise ArgumentError.new("It appears this customer id does not exist in our system.")
      end
    end #self.find end
  end #class end
end #module end

#
# frenchie = Grocery::Customer.all
#
# ##### I am surprised this worked!!####
# frenchie.each do |line|
#   puts line.all_info
#
# end
#
# hi =  Grocery::Customer.find(50)
# puts hi
