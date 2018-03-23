class AddImageUrlToStatements < ActiveRecord::Migration[5.1]
  def change
    add_column :statements, :image_url, :string
  end
end
