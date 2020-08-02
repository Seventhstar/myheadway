class CreateStatements < ActiveRecord::Migration[5.1]
  def change
    create_table :statements do |t|
      t.integer :author_id
      t.string :source
      t.string :theme
      t.text :content
      t.integer :user_id
      t.timestamps
    end
  end
end
