class Attention < ActiveRecord::Base
		belongs_to :object, class_name: "AttnCat", foreign_key: "attn_cat_id"
		belongs_to :author
	end
