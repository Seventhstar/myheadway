class CreateTargetDays < ActiveRecord::Migration[5.1]
  def change
    create_table :target_days do |t|
      t.boolean :checked
      t.integer :target_id
      t.integer :day
      t.integer :month
      t.integer :year

      t.timestamps
    end
  end
end
