json.array!(@catalogs_devices) do |catalogs_device|
  json.extract! catalogs_device, :id, :name, :unam_stock_number, :location_id
  json.url catalogs_device_url(catalogs_device, format: :json)
end
