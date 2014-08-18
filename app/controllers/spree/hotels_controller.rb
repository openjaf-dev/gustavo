class Spree::HotelsController < Spree::StoreController

  def index
  	@taxonomies = Spree::Taxonomy.includes(root: :children)

  	if params[:location_lat] && params[:location_lng]
	  	ean_response = $api.get_list( :latitude => params[:location_lat],
	  								 :longitude => params[:location_lng] )
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
  	ean_response = $api.get_information( :hotelId => params[:id] )
  	data = ean_response.body
  	@hotel_summary   = data['HotelInformationResponse']['HotelSummary']
    @hotel_detail    = data['HotelInformationResponse']['HotelDetails']
    @room_types      = data['HotelInformationResponse']['RoomTypes']['RoomType']
    @hotel_images    = data['HotelInformationResponse']['HotelImages']['HotelImage']


    @room_info
  end

end
