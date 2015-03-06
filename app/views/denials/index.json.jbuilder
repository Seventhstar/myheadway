json.array!(@denials) do |denial|
  json.extract! denial, :id, :name, :start_date
  json.url denial_url(denial, format: :json)
end
