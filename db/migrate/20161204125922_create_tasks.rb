class CreateTasks < ActiveRecord::Migration[5.1]
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
      t.boolean :upd_1c

      t.timestamps null: false
    end

    add_index :tasks, :guid_1c
    add_index :tasks, :task_cat_id

  end
end
