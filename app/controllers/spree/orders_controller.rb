module Spree
  class OrdersController < Spree::StoreController
    ssl_required :show

    # before_filter :check_authorization
    rescue_from ActiveRecord::RecordNotFound, :with => :render_404
    helper 'spree/products', 'spree/orders'

    respond_to :html

    before_filter :assign_order_with_lock, only: :update
    before_filter :apply_coupon_code, only: :update
    skip_before_filter :verify_authenticity_token

    def show
      @order = Order.find_by_number!(params[:id])
    end

    def update

      if !params[:order]
       order_hash = {}
       #TODO, this emial should come from somewhere
       order_hash[:order] = {:email => "spree@example.com", :line_items_attributes => {"0"=>{:quantity => @order.line_items.first.quantity.to_s, :id=>@order.line_items.first.id.to_s }}, :cupon_code=>""}
       params.merge!(order_hash)
      end
      if @order.contents.update_cart(order_params)
        respond_with(@order) do |format|
          format.html do
            if params.has_key?(:checkout)
              @order.next if @order.pax?
              redirect_to checkout_state_path(@order.checkout_steps.first)
            else
              flash.notice = Spree.t(:problem_booking)
              redirect_to root_path
            end
          end
        end
      else
        respond_with(@order)
      end
    end

    # Shows the current incomplete order from the session
    def edit
      @order = current_order || Order.new
      associate_user
      if stale?(current_order)
        respond_with(current_order)
      end
    end

    # Adds a new item to the order (creating a new order if none already exists)
    def populate
      Spree::Context.build_from_params(params)
      #TODO creo que aqui debo pedir información maś precisa, no pedirla toda
      a = $api.get_information( :hotelId => params[:hotelId] )
      data = a.body
      product = Spree::Product.create(:name => data['HotelInformationResponse']['HotelSummary']['name'],
                                      :available_on => Time.now,
                                      :shipping_category_id => Spree::ShippingCategory.first.id,
                                      :price => params['chargeableRate'])


      populator = Spree::OrderPopulator.new(current_order(create_order_if_necessary: true), current_currency)
      if populator.populate(product.master.id, params[:quantity])
        # current_order.ensure_updated_shipments
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

    def empty
      if @order = current_order
        @order.empty!
      end

      redirect_to spree.cart_path
    end

    def accurate_title
      if @order && @order.completed?
        Spree.t(:order_number, :number => @order.number)
      else
        Spree.t(:shopping_cart)
      end
    end

    # def check_authorization
    #   cookies.permanent.signed[:guest_token] = params[:token] if params[:token]
    #   order = Spree::Order.find_by_number(params[:id]) || current_order

    #   if order
    #     authorize! :edit, order, cookies.signed[:guest_token]
    #   else
    #     authorize! :create, Spree::Order
    #   end
    # end

    private

      def order_params
        if params[:order]
          params[:order].permit(*permitted_order_attributes,  pax_contacts_attributes: [:first_name, :last_name])
        else
          {}
        end
      end

      def assign_order_with_lock
        @order = current_order(lock: true)
        unless @order
          flash[:error] = Spree.t(:order_not_found)
          redirect_to root_path and return
        end
      end
  end
end
