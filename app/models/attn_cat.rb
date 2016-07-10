class AttnCat < ActiveRecord::Base
	has_many :attentions, foreign_key: :attn_cat_id
end
