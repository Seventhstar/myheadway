json.array!(@targets) do |target|
  json.extract! target, :name, :parent_id, :user_id, :group_id
  json.url target_url(target, format: :json)
end
