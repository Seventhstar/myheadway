json.array!(@books) do |book|
  json.extract! book, :name, :author_id
  json.url book_url(book, format: :json)
end
