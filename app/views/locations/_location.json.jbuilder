json.extract! location, :id, :user_id, :ip_address, :address_1, :address_2, :city, :state, :zip, :country, :lattitude, :longitude, :created_at, :updated_at
json.url location_url(location, format: :json)
