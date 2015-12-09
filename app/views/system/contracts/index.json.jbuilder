json.array!(@system_contracts) do |system_contract|
  json.extract! system_contract, :id, :device_id, :supplier_id, :start_date, :end_date, :contract_no
  json.url system_contract_url(system_contract, format: :json)
end
