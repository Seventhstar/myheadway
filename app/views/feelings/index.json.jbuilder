json.array!(@feelings) do |feeling|
  json.extract! feeling, :content, :day
  json.url feeling_url(feeling, format: :json)
end
