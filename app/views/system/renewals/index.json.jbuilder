json.array!(@system_renewals) do |system_renewal|
  json.extract! system_renewal, :id, :contract_id, :start_date, :end_date
  json.url system_renewal_url(system_renewal, format: :json)
end
