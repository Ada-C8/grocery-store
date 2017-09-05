require_relative 'order'
require 'csv'

class OnlineOrder < Grocery::Order
  attr_reader :customer, :status, :products, :id

  def initialize(id, products, customer, status)
    super(id, products)
    @customer = customer
    @status = status
  end

  def total # INVOKES METHOD FROM THE ORDER.RB CLASS
    total = super
    total == 0 ? 0 : total + 10.00
  end

  def add_product(product_name, product_price)
    if @status == :shipped || @status == :processing || @status == :complete
      raise ArgumentError.new("You cannot add a product at this time")
    else
      return super
    end
  end

  def self.all
    all_online_orders = []
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
      all_online_orders << online_order
    end
    return all_online_orders
  end

  def self.find(order_id)
    super
    # found_order = nil # RETURNS AN INSTANCE OF ONLINE ORDER THAT MATCHES THE ORDER_ID
    # self.all.each do |order|
    #   if order.id == order_id
    #     found_order = order
    #     return found_order # RETURNS AN INSTANCE OF ONLINE ORDER
    #   end
    # end
  end # DEF


  def self.find_by_customer(customer_id)
    # Returns a list of OnlineOrder instances where the value of the customer's ID matches the passed parameter.
    orders_by_cust_id = []
    self.all.each do |order|
      return orders_by_cust_id << order if order.customer.id == customer_id
    end
  end # DEF
end # CLASS
