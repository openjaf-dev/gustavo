module Spree
  CheckoutController.class_eval do


  def update

      if @order.update_from_params(params, permitted_checkout_attributes, request.headers.env)
        if @order.email == "spree@example.com"
	  	    @order.email = params[:order][:bill_address_attributes][:email]
	      end
        persist_user_address

        if params[:commit] == "Complete Reservation"  && params[:state] == "confirm"
          hash = eval(@order.context.context)
          ean_response = $api.get_reservation( :hotelId => hash[:hotelId],
                                               :arrivalDate => hash[:arrivalDate],
                                               :departureDate => hash[:departureDate],
                                               :rateKey => hash[:rateKey],
                                               :roomTypeCode => hash[:roomTypeCode],
                                               :rateCode => hash[:rateCode],
                                               :chargeableRate => hash[:chargeableRate]

          )
          if ean_response.class == Expedia::APIError
            flash.notice = ean_response.presentation_message
            redirect_to root_path
          else
            #data = ean_response.body
            #@hotel_list = data['HotelListResponse']['HotelList']['HotelSummary']
          end
        else

        end

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

	  if @order.pax_contacts.empty?

      context = eval(@order.context.context)
      counter = 0
      context.each do |key, value|
         if key == key.scan(/room[0-9]*$/).first
           counter += 1
         end
      end
      counter.times { @order.pax_contacts.new }

    end

	end

  end
end
