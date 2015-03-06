class CreateDenials < ActiveRecord::Migration
  def change
    create_table :denials do |t|
      t.string :name
      t.timestamps :start_date

      t.timestamps
    end
  end
end
