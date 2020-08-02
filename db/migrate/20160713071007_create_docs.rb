class CreateDocs < ActiveRecord::Migration[5.1]
  def change
    create_table :docs do |t|
      t.string :name
      t.integer :doc_type_id
      t.text :description

      t.timestamps null: false
    end
  end
end
