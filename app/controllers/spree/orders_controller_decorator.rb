Spree::OrdersController.class_eval do

    # Adds a new item to the order (creating a new order if none already exists)
    def populate

      Spree::Context.build_from_params(params)

      a = $api.get_information( :hotelId => params[:hotelId] )
      data = a.body
      product = Spree::Product.create(:name => data['HotelInformationResponse']['HotelSummary']['name'],
                                      :available_on => Time.now,
                                      :shipping_category_id => Spree::ShippingCategory.first.id,
                                      :price => params['chargeableRate'])


      populator = Spree::OrderPopulator.new(current_order(create_order_if_necessary: true), current_currency)
      if populator.populate(product.master.id, params[:quantity])
        current_order.ensure_updated_shipments
        # respond_with(@order) do |format|
        @order = current_order
        self.update
          # format.html { redirect_to cart_path }
        # end
      else
        flash[:error] = populator.errors.full_messages.join(" ")
        redirect_to :back
      end
    end

    def update
      params[:checkout] = true
      if @order.contents.update_cart(order_params)
        respond_with(@order) do |format|
          format.html do
            if params.has_key?(:checkout)
              @order.next if @order.cart?
              redirect_to checkout_state_path(@order.checkout_steps.first)
            else
              redirect_to cart_path
            end
          end
        end
      else
        respond_with(@order)
      end
    end

end
