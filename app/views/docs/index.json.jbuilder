json.array!(@docs) do |doc|
  json.extract! doc, :id, :name, :doc_type_id, :description
  json.url doc_url(doc, format: :json)
end
