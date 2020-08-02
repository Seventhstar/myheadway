class AddImgUrlToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :img_url, :string
    add_column :books, :annotation, :text
    add_column :books, :order, :integer
  end
end
