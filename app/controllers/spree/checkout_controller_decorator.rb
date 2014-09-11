module Spree
  CheckoutController.class_eval do


    def update

      if @order.update_from_params(params, permitted_checkout_attributes, request.headers.env)
        if @order.email == "spree@example.com"
	  	  @order.email = params[:order][:bill_address_attributes][:email]
	    end
        persist_user_address
        unless @order.next
          flash[:error] = @order.errors.full_messages.join("\n")
          redirect_to checkout_state_path(@order.state) and return
        end

        if @order.completed?
          @current_order = nil
          flash.notice = Spree.t(:order_processed_successfully)
          flash[:order_completed] = true
          redirect_to completion_route
        else
          redirect_to checkout_state_path(@order.state)
        end
      else
        render :edit
      end
    end


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
