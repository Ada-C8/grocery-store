require 'csv'


module Grocery

  class Customer

    @@all_customers = Array.new

    attr_reader :customer_id, :email, :delivery_address

    def initialize(id, email, delivery_address)
      @customer_id = id.to_i
      @email = email
      @delivery_address = delivery_address
    end

    #   # self.all - returns a collection of Customer instances, representing all of the Customer described in the CSV. See below for the CSV file specifications

    def self.all

      @@all_customers = []

      CSV.open('../support/customers.csv', 'r').each do |line|
        line[0] = line[0].to_i
        line[2] = line[2] + ", " + line[3] + ", " + line[4] + ", " + line[5]
        line.delete_at(5)
        line.delete_at(4)
        line.delete_at(3)
        @@all_customers << Customer.new(line[0], line[1], line[2])
      end #csv each
      return @@all_customers
    end #self.all method

    def self.all_customers
      return @@all_customers
    end

    def self.find(id)
      # self.find(id) - returns an instance of Order where the value of the id field in the CSV matches the passed parameter.
      customers = Grocery::Customer.all
      item_num = []

      customers.each do |item|
        item_num << item.customer_id
      end

      if item_num.include?(id)
        return customers[id - 1]
      else
        raise ArgumentError, "ID not found."
      end
    end# method def
  end #customer class
end #module

puts Grocery::Customer.find(10).inspect
puts Grocery::Customer.find(350)


#def self.find(id)
#   CSV.open('../support/customers.csv', 'r').each do |line|
#     if id.to_i == line[0].to_i #begin if statement
#       line[0] = line[0].to_i
#       line[2] = line[2] + ", " + line[3] + ", " + line[4] + ", " + line[5]
#       line.delete_at(5)
#       line.delete_at(4)
#       line.delete_at(3)
#       return Customer.new(line[0], line[1], line[2])
#       #break
#     end # if statement
#   end #CSV each
# end# method def


# puts Grocery::Customer.find(1).delivery_address
# puts Grocery::Order.find(10).show_order
# 1,leonard.rogahn@hagenes.org,71596 Eden Route,Connellymouth,LA,98872-9105
# 35,rogers_koelpin@oconnell.org,7513 Kaylee Summit,Uptonhaven,DE,64529-2614
