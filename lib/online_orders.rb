require 'csv'
require_relative 'order'
require_relative 'customers'

module Grocery
  class OnlineOrder < Order
    @@csv = "../support/online_orders.csv"

    # def initialize
    #   @csv = "../support/online_orders.csv"
    # end

    def self.all
      super
    end

    # Maria - split .all method into 3 parts, all has the csv
    # My proccess could be broken into self.all with csv and the
    # instance creator
    # put an if statement in the all method to run extra code
    # depending on csv provided
  end
end

# id = 1337
# products = { "banana" => 1.99, "cracker" => 3.00, "sandwich" => 4.25 }
# online_order = Grocery::Order.new(id,products)
# puts online_order.class

p "OnlineOrder"
p Grocery::OnlineOrder.find(3)
