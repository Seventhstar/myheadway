class CreateClaims < ActiveRecord::Migration[5.1]
  def change
    create_table :claims do |t|
      t.string :name
      t.datetime :date
      t.integer :user_id
      t.boolean :reached

      t.timestamps null: false
    end
  end
end
