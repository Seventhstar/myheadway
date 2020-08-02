class CreateSearchSuggestions < ActiveRecord::Migration[5.1]
  def change
    create_table :search_suggestions do |t|
      t.string :term
      t.integer :author

      t.timestamps
    end
  end
end
