class Spree::HotelsController < Spree::StoreController

  def index
  	@taxonomies = Spree::Taxonomy.includes(root: :children)

   #roomGroup"=>{"room1"=>{"numberOfAdults"=>"2", "numberOfChildren"=>"2", "age1"=>"2", "age2"=>"3"}}

    #TODO hay que cambiar que cuando se elimine un room,
    # los que est'an debajo se corran hacia arriba con el n'umero de la
    #habitaci'on consecutivamente
    #TODO en vez de cojer @key , value@ hacerlo con 'each with index'
    #TODO meter este codiguito en un m'etodo que sea API.ean_to_params
    ean_params= {}
    params[:roomGroup].each do |key, value|
        ages = ""
        if value[:numberOfChildren].to_i > 0
          for i in 1..value[:numberOfChildren].to_i
            ages += value["age#{i}"]
            ages += "," if i != value[:numberOfChildren].to_i

          end
          params.merge!(key => "#{value[:numberOfAdults]}"+","+ages)
          ean_params[key] = "#{value[:numberOfAdults]}"+","+ages
        else
          params.merge!(key => value[:numberOfAdults])
          ean_params[key] = value[:numberOfAdults]
          #params.merge!(key => "1,3,5")
          #params.merge!(:room2 => "2")
          #params.merge!(:room3 => "3")
        end
    end

    # {:latitude=>"43.0481221", :longitude=>"-76.14742439999998",
    # :arrivalDate=>"09-12-2014", :departureDate=>"09-15-2014",
    # :room1=>"2,3"}

    # TODO: el metodito API.params_to_ean devuelve ean_params
  	if (params[:location_lat] != "") && (params[:location_lng] != "")
      ean_params[:latitude] = params[:location_lat]
      ean_params[:longitude] = params[:location_lng]
      ean_params[:arrivalDate] = params[:arrivalDate]
      ean_params[:departureDate ] = params[:departureDate]

      ean_response = $api.get_list( ean_params)

      if ean_response.class == Expedia::APIError
          flash.notice = ean_response.presentation_message
          redirect_to root_path
      else
        data = ean_response.body
        @hotel_list = data['HotelListResponse']['HotelList']['HotelSummary']
      end

    elsif (params[:location_lat] == "") && (params[:location_lng] == "")
            ean_response = $api.get_list( :destinationString => params[:location_search],
                                    :arrivalDate => params[:arrivalDate],
                                    :departureDate => params[:departureDate],
                                    :room1 => '1,3,5', :room2=>'2', :room3 => '3')

            if ean_response.class == Expedia::APIError
                flash.notice = ean_response.presentation_message
                redirect_to root_path
            else
              data = ean_response.body
              @hotel_list = data['HotelListResponse']['HotelList']['HotelSummary']
            end
	  else
            redirect_to root_path
	  end

  end

  def show
  	ean_hotel_info = $api.get_information( :hotelId => params[:id] )
  	data = ean_hotel_info.body
  	@hotel_summary   = data['HotelInformationResponse']['HotelSummary']
    @hotel_detail    = data['HotelInformationResponse']['HotelDetails']
    @room_types      = data['HotelInformationResponse']['RoomTypes']
    @hotel_images    = data['HotelInformationResponse']['HotelImages']

      ean_availability = $api.get_availability( :hotelId => @hotel_summary['hotelId'],
                                          :arrivalDate => params[:arrivalDate],
                                          :departureDate => params[:departureDate],
                                          :includeDetails=> true,
                                          :includeRoomImages=>true,
                                          :room1 => '1,3,5', :room2=>'2', :room3 => '3'
                                          )
    @rooms = []
    params.each do |key, value|
      if  key == key.scan(/room[0-9]*$/).first
         @rooms<<key
      end
    end


    if ean_availability.class == Expedia::APIError
        flash.notice = ean_availability.presentation_message
        redirect_to :back
    else
      data = ean_availability.body
      @availability = data['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    end


  end

end
