class CreatePriorities < ActiveRecord::Migration[5.1]
  def change
    create_table :priorities do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
