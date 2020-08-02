class CreateDocTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :doc_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
