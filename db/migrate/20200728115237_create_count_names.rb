class CreateCountNames < ActiveRecord::Migration[5.1]
  def change
    create_table :count_names do |t|
      t.string :name

      t.timestamps
    end
  end
end
