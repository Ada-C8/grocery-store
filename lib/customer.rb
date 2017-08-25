require 'csv'

class Customer

  @@all_customers = Array.new

  attr_reader :id, :email, :delivery_address

  def initialize(id, email, delivery_address)
    @id = id.to_i
    @email = email
    @delivery_address = delivery_address
  end

  #   # self.all - returns a collection of Customer instances, representing all of the Customer described in the CSV. See below for the CSV file specifications

  def self.all
    CSV.open('../support/customers.csv', 'r').each do |line|
      line[0] = line[0].to_i
      line[2] = line[2] + ", " + line[3] + ", " + line[4] + ", " + line[5]
      line.delete_at(5)
      line.delete_at(4)
      line.delete_at(3)
      @@all_customers << Customer.new(line[0], line[1], line[2])
      #puts "#{line}"
    end #csv each
    return @@all_customers
  end #self.all method

  def self.all_customers
    return @@all_customers
  end

  def self.show_customers
    list = ""
    @@customers.each do |id, email, delivery_address|
      list += "#{id}:\t #{email}\n#{delivery_address}\n"
    end #each end
    return list
  end #show order method end


end #customer class
# customer = Customer.new(5, "amymcash@gmail.com", "123 Fake St., Anytown, USA, 12345")
#
# puts customer.id.class
puts Customer.all.show_customers
# end
#
# def self.find(id)
#   # self.find(id) - returns an instance of Customer where the value of the id field in the CSV matches the passed parameter.
# end
