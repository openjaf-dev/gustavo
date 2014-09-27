module Spree::HotelsHelper

  def hotels_path(id, params)
    link = "hotels/#{id}"
    if params
      link += "?"
      params.each do |key, value|
        link += "#{key}=#{value}&"
      end
    end
    link
  end

end
