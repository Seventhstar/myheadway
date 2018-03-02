class CreateTaskCats < ActiveRecord::Migration[5.1]
  def change
    create_table :task_cats do |t|
      t.string :name
      t.string :code1c
      t.timestamps null: false
    end

    add_index :task_cats, :code1c
  end
end
