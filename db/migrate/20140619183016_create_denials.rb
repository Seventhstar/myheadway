class CreateDenials < ActiveRecord::Migration[5.1]
  def change
    create_table :denials do |t|
      t.string :name
      t.datetime :start_date
      t.timestamps
    end
  end
end
