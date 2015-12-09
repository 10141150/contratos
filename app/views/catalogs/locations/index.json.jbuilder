json.array!(@catalogs_locations) do |catalogs_location|
  json.extract! catalogs_location, :id, :department, :responsible, :email
  json.url catalogs_location_url(catalogs_location, format: :json)
end
