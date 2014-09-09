module Spree
  CheckoutController.class_eval do

	def before_pax
	  # TODO aqui se da el problema de que la cantidad de pax se suman por el tema de la session que no aspira
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
