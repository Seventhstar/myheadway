json.array!(@authors) do |author|
  json.extract! author, :name
  json.url author_url(author, format: :json)
end
