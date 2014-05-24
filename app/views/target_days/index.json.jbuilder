json.array!(@target_days) do |target_day|
  json.extract! target_day, :checked, :target_id, :day, :month, :year
  json.url target_day_url(target_day, format: :json)
end
