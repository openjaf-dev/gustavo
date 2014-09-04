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
    roomGroup = { }
    params[:roomGroup].each do |room|
      roomGroup.merge!(room: room)
    end

  	if (params[:location_lat] != "") && (params[:location_lng] != "")
	  	      ean_response = $api.get_list( :latitude => params[:location_lat],
	  								                :longitude => params[:location_lng],
                                    :arrivalDate => params[:arrivalDate],
                                    :departureDate => params[:departureDate],
                                    :roomGroup => roomGroup )
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
                                    :roomGroup => roomGroup )
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
    @hotel_images    = data['HotelInformationResponse']['HotelImages']['HotelImage']

    # @availability = []
    # @room_types['RoomType'].each do |rt|

      ean_availability = $api.get_availability( :hotelId => @hotel_summary['hotelId'],
                                          :arrivalDate => params[:arrivalDate],
                                          :departureDate => params[:departureDate],
                                          :roomGroup => params[:roomGroup]
                                          # , :roomCodeType => rt['@roomCode']
                                          )
      data = ean_availability.body
      @availability = data['HotelRoomAvailabilityResponse']['HotelRoomResponse']

    # end

  end

end
