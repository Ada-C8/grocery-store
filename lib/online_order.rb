require 'csv'
require_relative 'order'

module Grocery
  class OnlineOrder < Order
    attr_reader :customer_id, :status
    ## additional attributes (does that mean the arguments we pass in initialize?)
    #customer object
    #fulfillment status (SYMBOL)
    #pending, paid, shipped/complete
    #if no status, default - pending

    def initialize(id, products, customer_id, status = :pending)
      ##??? does the location of the super matter? Is it like return,
      ## where it needs to be added at the bottom?
      #in the case of ruby, doesn't matter but first will usually make the most sense
      super(id, products)
      @customer_id = customer_id
      @status = status.to_sym
      #might need a customer class initiated?
    end #intialize end

    # add product updated to permit new product to be added ONLY if status is pending or paid
    #otherwise, raise argument error
    def add_product(product_name, product_price)
      unless @status == :shipped || @status == :processing || @status == :completed
        super(product_name, product_price)
      else
        return raise ArgumentError.new("Your order is processing, complete or shipped and you cannot add a product at this time.")
      end
    end #add_product end


    def total
      super
      # $10 shipping fee
      if expected_total != 0 || expected_total != nil
        order_total = expected_total + 10
        return order_total
      else
        return raise ArgumentError.new("It appears there is nothing in your cart.")
      end
    end #total end

    # collection of OnlineOrder instances - all OO described in CSV
    # what is the same from the order.all method? what's the diff?
    #need to store status as symbol
    def self.all
      all_orders = []

      CSV.open("support/online_orders.csv", "r").each do |line|
        # puts "Read line #{line}"
        id = line[0].to_i
        # puts "id is #{id} and the class is #{id.class}"
        product_array = line[1].split(/;|:/)
        # puts "array is #{product_array} and class is #{product_array.class}"
        customer_id = line[2].to_i
        # puts "Customer id: #{customer_id} and class is #{customer_id.class}"
        status = line[3].to_sym
        # puts "status is #{status} and class is #{status.class}"
        # puts "decoded to id #{id}, products #{product_array}"

        product_hash = {}
        product_name = nil
        product_array.each_with_index do |value, i|
          if i % 2 == 0
            product_name = value
          elsif i % 2 == 1
            product_hash[product_name] = value.to_f
          end
        end #each/do end

        puts "turned product array into hash #{product_hash}"

        order = OnlineOrder.new(id, product_hash, customer_id, status)
        all_orders << order
        return all_orders
      end
    end #self.all end

    #instance of OO where value in id field matches CSV parameter
    # what is different about this find method vs order.find method?
    def self.find(id)
      order_num_array = []

      CSV.open("support/online_orders.csv", "r").each do |line|
        # puts "Read line #{line}"
        id = line[0].to_i
        order_num_array << id
      end

      if order_num_array.include?(order_num)
        puts "Great we have your order!"
        CSV.open("support/online_orders.csv", "r").each do |line|
          id = line[0].to_i
          if id == order_num
            product_array = line[1].split(/;|:/)

            product_hash = {}
            product_name = nil
            product_array.each_with_index do |value, i|
              if i % 2 == 0
                product_name = value
              elsif i % 2 == 1
                product_hash[product_name] = value.to_f
              end #if/elsif end
            end #each do end
            customer_id = line[2].to_i
            status = line[3].to_sym
            puts "The products for order #{id} are: #{product_hash}"
            puts "The order is #{status.to_s} and the customer id is #{customer_id}."
            return order_num_array
          end # if end
        end #each/do end
        # when Order.find is called with an ID that doesn't exist?
      else
        ##### raise error --- look at deck method!!!
        ### it will use proc syntax for testing
        puts "Sorry, it appears we don't have an order #{order_num}."
      end #id/else end
    end #def self.find end

    # returns a list of online order instances where cust id matches passed parameter
    def self.find_by_customer(customer_id)
      cust_id_array = []

      CSV.open("support/online_orders.csv", "r").each do |line|
        # puts "Read line #{line}"
        # puts "line 2: #{line[2]}"
        if line[2].to_i == customer_id
          id = line[0].to_i
          product_array = line[1].split(/;|:/)

          product_hash = {}
          product_name = nil
          product_array.each_with_index do |value, i|
            if i % 2 == 0
              product_name = value
            elsif i % 2 == 1
              product_hash[product_name] = value.to_f
            end #if/elsif end
          end #each do end
          customer_id = line[2].to_i
          status = line[3].to_sym

          cust_id_array << OnlineOrder.new(id, product_hash, customer_id, status)
          # puts "The order id is: #{id}  and the order is: #{product_hash}"
          # puts "The order is #{status.to_s} and the customer id is #{customer_id}."
          # return cust_id_array
        end # if end
      end #each/do end


      if cust_id_array.empty?
        puts "Sorry, it appears we don't have an order for customer #{customer_id}."
      else cust_id_array.length >= 1
        puts "Customer #{customer_id} has the following orders:"
        cust_id_array.each do |line|
          puts "Order id: #{line.id} ** Order: #{line.products} ** Status: #{line.status}."
        end
      end #id/else end
    end #def self.find_by_customer end
  end #order end

end #module end


puts Grocery::OnlineOrder.find_by_customer(1)



### Need to work on getting the total amount to pass when trying to add shipping fee
