json.array!(@statements) do |statement|
  json.extract! statement, :author_id, :source, :theme, :content
  json.url statement_url(statement, format: :json)
end
