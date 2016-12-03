class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.string :guid_1c
      t.integer :task_cat_id
      t.integer :priority_id
      t.date :start_date
      t.boolean :fixed

      t.timestamps null: false
    end
  end
end
