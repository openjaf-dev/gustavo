json.array!(@spree_admin_locations) do |spree_admin_location|
  json.extract! spree_admin_location, :id, :address, :location_name, :phone_number, :distric, :city, :postcode, :country, :lat, :lng, :reference, :enabled
  json.url spree_admin_location_url(spree_admin_location, format: :json)
end
