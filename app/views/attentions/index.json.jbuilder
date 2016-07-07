json.array!(@attentions) do |attention|
  json.extract! attention, :id, :name, :user_id, :description, :src_url, :img_url, :attn_cat_id
  json.url attention_url(attention, format: :json)
end
