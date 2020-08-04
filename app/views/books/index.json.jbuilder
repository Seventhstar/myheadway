json.array!(@books) do |book|
  json.extract! book, :name, :author_id, :author_name
  json.url book_url(book, format: :json)
end
