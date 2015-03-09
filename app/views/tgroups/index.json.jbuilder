json.array!(@tgroups) do |tgroup|
  json.extract! tgroup, :id, :name
  json.url tgroup_url(tgroup, format: :json)
end
