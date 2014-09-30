module Spree::HotelsHelper

  def hotels_path(id, params)
    link = "hotels/#{id}?arrivalDate=#{params[:arrivalDate]}&departureDate=#{params[:departureDate]}&"
    a = {}
    rooms = Ean.room_group_convert(a, params)
    rooms.each do |key, value|
        link += "#{key}=#{value}&"
    end
    link
  end

end
