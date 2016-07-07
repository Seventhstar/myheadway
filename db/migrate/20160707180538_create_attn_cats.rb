class CreateAttnCats < ActiveRecord::Migration
  def change
    create_table :attn_cats do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
