class Ean

  def self.room_group_convert(hash, params)

    #TODO hecho con 'each_with_index' hasta que se solucione la consecutidad de las habitaciones
    params[:roomGroup].each_with_index do |room, i|

      ages = ""
      if room[1][:numberOfChildren].to_i > 0
        for j in 1..room[1][:numberOfChildren].to_i
          ages += room[1]["age#{j}"]
          ages += "," if j != room[1][:numberOfChildren].to_i

        end
        hash["room"+(i+1).to_s] = "#{room[1][:numberOfAdults]}"+","+ages
      else
        hash["room"+(i+1).to_s] = room[1][:numberOfAdults]
      end
    end
    hash
  end

  def self.ean_to_params

  end

  def self.to_ean(params)

    ean_params= {}
    ean_params[:arrivalDate] = params[:arrivalDate]
    ean_params[:departureDate ] = params[:departureDate]

    room_group_convert(ean_params, params)

    #TODO duda si es mejor hacerlo con Lat y Long y no con el location_search
    if (params[:location_lat] != "") && (params[:location_lng] != "")

      ean_params[:latitude] = params[:location_lat]
      ean_params[:longitude] = params[:location_lng]

    elsif (params[:location_lat] == "") && (params[:location_lng] == "")

      ean_params[:location_search] = params[:location_search]

    else
      #TODO, ver aqui que otra cosa se puede devolver
      redirect_to root_path
    end

    ean_params

  end

end