class Ean

  def self.ean_to_params

  end

  def self.to_ean(params)

    ean_params= {}
    ean_params[:arrivalDate] = params[:arrivalDate]
    ean_params[:departureDate ] = params[:departureDate]

    #TODO hecho con 'each_with_index' hasta que se solucione la consecutidad de las habitaciones
      params[:roomGroup].each_with_index do |room, i|

      ages = ""
      if room[1][:numberOfChildren].to_i > 0
        for j in 1..room[1][:numberOfChildren].to_i
          ages += room[1]["age#{j}"]
          ages += "," if j != room[1][:numberOfChildren].to_i

        end
        ean_params["room"+(i+1).to_s] = "#{room[1][:numberOfAdults]}"+","+ages
      else
        ean_params["room"+(i+1).to_s] = room[1][:numberOfAdults]
      end
    end

    asasasdas
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