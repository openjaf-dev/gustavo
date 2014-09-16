class Spree::HotelsController < Spree::StoreController

  def index
  	@taxonomies = Spree::Taxonomy.includes(root: :children)


    # <RoomGroup>
    #     <Room>
    #         <numberOfAdults>2</numberOfAdults>
    #     </Room>
    #     <Room>
    #         <numberOfAdults>2</numberOfAdults>
    #     </Room>
    # </RoomGroup>
    #
    #  roomGroup => {
    #     0 => {
    #       :numberOfAdults => 2
    #     },
    #     1 => {
    #       :numberOfAdults => 2
    #     },
    #   }
    # #

    # "roomGroup"=>{"room1"=>{"numberOfAdults"=>"[FILTERED]", "numberOfChildren"=>"[FILTERED]", "childAges"}}
    # "roomGroup"=>{"room1"=>{"numberOfAdults"=>"[FILTERED]", "childAges" => "4,5,6"}}

    #params[:roomGroup].each do |room|
    #    if room[:childAges]
    #      params.merge!(room => "#{room[:numberOfAdults]}"+","+"#{room[:childAges]}")
    #    else
    #      params.merge!(room => "#{room[:numberOfAdults]}")
    #    end
    #end

    # {:latitude=>"43.0481221", :longitude=>"-76.14742439999998",
    # :arrivalDate=>"09-12-2014", :departureDate=>"09-15-2014",
    # :room1=>"2,3"}

  	if (params[:location_lat] != "") && (params[:location_lng] != "")
	  	      ean_response = $api.get_list( :latitude => params[:location_lat],
	  								                :longitude => params[:location_lng],
                                    :arrivalDate => params[:arrivalDate],
                                    :departureDate => params[:departureDate] )
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
                                    :roomGroup => params[:roomGroup] )
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
                                          :roomGroup => params[:roomGroup]
                                          )
      if ean_availability.class == Expedia::APIError
          flash.notice = ean_availability.presentation_message
          redirect_to :back
      else
        data = ean_availability.body
        @availability = data['HotelRoomAvailabilityResponse']['HotelRoomResponse']
      end


  end

end
