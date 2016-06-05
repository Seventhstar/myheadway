json.array!(@claims) do |claim|
  json.extract! claim, :id, :name, :date, :user_id, :reached
  json.url claim_url(claim, format: :json)
end
