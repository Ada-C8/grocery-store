require 'csv'

module Grocery
  class Costumer
    attr_reader :id, :email, :address

    def initialize(id, email, address)
      @id = id
      @email = email
      @address = address
    end

    def self.all
      allcostumers = []
      CSV.open('support/customers.csv', "r").each do |person|
        address = {}
        address["Address 1"] = person[2]
        address["City"] = person[3]
        address["State"] = person[4]
        address["Zip-Code"] = person[5]
        newcostumer = Grocery::Costumer.new(person[0].to_i, person[1], address)
        allcostumers << newcostumer
      end
      return allcostumers
    end# end all

    def self.find(id)
      self.all.each do |person|
        if person.id == id
          return person
        end
      end
        raise ArgumentError.new("The given id doesn't corespond to a costumer.")
    end #find



  end #costumer end
end #grocery end



#print Grocery::Costumer.all
