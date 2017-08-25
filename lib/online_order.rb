require 'pry'
require 'csv'

class OnlineOrder < Order

  def initialize(id, products, customer_id, status)
    super
    @customer_id = customer_id
    @status = status.to_sym
  end

  def self.all
    #no super because super takes the out put for orders and gives back @@all_orders, in this case we dont care about that we want all the online orders
  end

  def find.all
    super
  end

  def total
    super
  end

  def add_product
    super
  end


end
