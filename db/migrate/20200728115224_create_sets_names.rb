class CreateSetsNames < ActiveRecord::Migration[5.1]
  def change
    create_table :sets_names do |t|
      t.string :name

      t.timestamps
    end
  end
end
