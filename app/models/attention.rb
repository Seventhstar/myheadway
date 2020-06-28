class Attention < ActiveRecord::Base
  belongs_to :object, class_name: "AttnCat", foreign_key: "attn_cat_id"
  belongs_to :author

  def image
    img_url.empty? ? 'noimage.png' : img_url
  end
end
