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
      order_id = line[0
      line[1].split(";").each do |item_and_price|
        split = item_and_price.split(":")
        items[split[0]] = split[1].to_f.round(2)
      end
      Grocery::OnlineOrder(line[0].to_i, online_products, customer, status )
    end


      order = Grocery::Order.new(line[0].to_i, items)
      @@all_orders << order


  end

    # returns a collection of OnlineOrder instances, representing all of the OnlineOrders described in the CSV. See below for the CSV file specifications
    # Question Ask yourself, what is different about this all method versus the Order.all method? What is the same?
    # order_id

    #
    # current_customer = G::Customer.find(customer_id)
    # current_order_status = status_id
    # OnlineOrder.new(current_customer, current_order_status

  def self.find(id)
    # returns an instance of OnlineOrder where the value of the id field in the CSV matches the passed parameter. -Question Ask yourself, what is different about this find method versus the Order.find method?
  end
  def self.find_by_customer(customer_id)
    #returns a list of OnlineOrder instances where the value of the customer's ID matches the passed parameter.
  end


end # CLASS
