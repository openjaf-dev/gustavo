module Spree
  CheckoutController.class_eval do

	def before_pax
	  if @order.pax_contacts.empty?
	    sum = 0
	    @order.line_items.each do |li|
	      sum += li.quantity
	    end
	    sum.times { @order.pax_contacts.new }
	  end
	end

  end
end
