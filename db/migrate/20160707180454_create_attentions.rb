class CreateAttentions < ActiveRecord::Migration
  def change
    create_table :attentions do |t|
      t.string :name
      t.integer :user_id
      t.text :description
      t.string :src_url
      t.string :img_url
      t.integer :attn_cat_id

      t.timestamps null: false
    end
  end
end
