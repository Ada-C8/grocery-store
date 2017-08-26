require_relative 'order'
require 'csv'

class OnlineOrder < Grocery::Order
  attr_reader :customer, :status, :products, :id

  @@all_online_orders = []

  def initialize(id, products, customer, status)
    super(id, products)
    @customer = customer
    @status = status
  end

  def total # INVOKES METHOD FROM THE ORDER.RB CLASS
    if super == 0
      return 0
    else
      return super + 10.00
    end
  end

  def add_product(product_name, product_price)
    if @status == :shipped || @status == :processing || @status == :complete
      raise ArgumentError.new("You cannot add a product at this time")
    else
      return super
    end
  end

  def self.all
    @@all_online_orders = []
    CSV.open("support/online_orders.csv", 'r').each do |line|
      online_products = {}
      customer = Grocery::Customer.find(line[-2].to_i) # SHOULD RETURN AN INSTANCE OF A GROCERY::CUSTOMER AT EACH LINE
      # RUN LOOP STARTING AT INDEX 1 FOR ARRAY TO SPLIT THE CSV IN THE APPROPRIATE FIELDS
      line[1].split(";").each do |item_and_price|
        split = item_and_price.split(":")
        online_products[split[0]] = split[1].to_f.round(2)
      end
      # LINE -2 IS THE CUSTOMER ID, LINE -1 IS THE ORDER STATUS
      online_order = OnlineOrder.new(line[0].to_i, online_products, customer, line[-1].to_sym)
      @@all_online_orders << online_order
    end
    return @@all_online_orders
  end

  def self.find(order_id)
    found_order = nil # RETURNS AN INSTANCE OF ONLINE ORDER THAT MATCHES THE ORDER_ID
    CSV.open("support/online_orders.csv", 'r').each do |line|
      customer = Grocery::Customer.find(line[-2].to_i)
      if line[0].to_i == order_id
        online_products = {}
        line[1].split(";").each do |item_and_price|
          split = item_and_price.split(":")
          online_products[split[0]] = split[1].to_f.round(2)
        end
        # LINE -2 IS THE CUSTOMER ID, LINE -1 IS THE ORDER STATUS
        online_order = OnlineOrder.new(line[0].to_i, online_products, customer, line[-1].to_sym)
        found_order = online_order
        break
      end
    end
    return found_order # RETURNS AN INSTANCE OF ONLINE ORDER
  end # DEF


  def self.find_by_customer(customer_id)
    #returns a list of OnlineOrder instances where the value of the customer's ID matches the passed parameter.
    # order = [ order order order] --> each order is the same number customer id
    orders_by_cust_id = []
    CSV.open("support/online_orders.csv", 'r').each do |line|
      customer = Grocery::Customer.find(line[-2].to_i)
      if line[-2].to_i == customer_id
        online_products = {}
        line[1].split(";").each do |item_and_price|
          split = item_and_price.split(":")
          online_products[split[0]] = split[1].to_f.round(2)
        end
        # LINE -2 IS THE CUSTOMER ID, LINE -1 IS THE ORDER STATUS
        online_order = OnlineOrder.new(line[0].to_i, online_products, customer, line[-1].to_sym)
        orders_by_cust_id << online_order
      end
    end
    return orders_by_cust_id
  end # DEF
end # CLASS
