json.array!(@system_siteviews) do |system_siteview|
  json.extract! system_siteview, :id, :contract_id, :visit_date, :completed
  json.url system_siteview_url(system_siteview, format: :json)
end
