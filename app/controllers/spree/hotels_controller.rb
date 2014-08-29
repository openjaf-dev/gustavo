class Spree::HotelsController < Spree::StoreController

  def index
  	@taxonomies = Spree::Taxonomy.includes(root: :children)


    # if params[:rooms]

    #   hash = {}
    #   hash = :RoomGroup => ''

    # end
    # hash = {}
    # hash = :RoomGroup => { :Room => { :numberOfAdults => '2'} }

    # <RoomGroup>
    #     <Room>
    #         <numberOfAdults>2</numberOfAdults>
    #     </Room>
    # </RoomGroup>

  	if params[:location_lat] && params[:location_lng]
	  	ean_response = $api.get_list( :latitude => params[:location_lat],
	  								                :longitude => params[:location_lng],
                                    :arrivalDate => params[:arrivalDate],
                                    :departureDate => params[:departureDate]  )
	  else
		  ean_response = $api.get_list( :destinationString => params[:location_search] )
	  end

# 	if ean_response.category
# 		response = ean_response.category
# 		case response
# 		when "RESULT_NULL"
# 		when "DATA_VALIDATION"
# 			# aqui van todas las valicdaciones
# 			# 1- No se permiten reservaciones por m'as de 30 d'ias
# 			# 2- 500 d'as es el maximo de reservacion de una habitacion
# 			# 3- fecha alreves
# 			ean_response = $api.geo_search({ :destinationString => params[:location_search]})
# 			ean_response = $api.get_list({ :destinationString => ean_response})
# 			data = ean_response.body
# 	  	    @hotel_list = data['HotelListResponse']['HotelList']['HotelSummary']

# 		when "RESULT_NULL"
# 		else
#           puts "You just making it up!"
#         end
# 	else
      	data = ean_response.body
  	  	@hotel_list = data['HotelListResponse']['HotelList']['HotelSummary']
# 	end

  end

  def show
  	ean_hotel_info = $api.get_information( :hotelId => params[:id] )
  	data = ean_hotel_info.body
  	@hotel_summary   = data['HotelInformationResponse']['HotelSummary']
    @hotel_detail    = data['HotelInformationResponse']['HotelDetails']
    @room_types      = data['HotelInformationResponse']['RoomTypes']
    @hotel_images    = data['HotelInformationResponse']['HotelImages']['HotelImage']

    @availability = []
    @room_types['RoomType'].each do |rt|

      ean_availability = $api.get_availability( :hotelId => @hotel_summary['hotelId'],
                                          :arrivaldate => '9/17/2014', :departuredate=> '9/19/2014',
                                          :numberofadults => '2', :roomcodetype => rt['@roomCode'] )
      data = ean_availability.body
      @availability << data['HotelRoomAvailabilityResponse']['HotelRoomResponse']

    end




  end

end
