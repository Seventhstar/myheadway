class CreateTaskCats < ActiveRecord::Migration
  def change
    create_table :task_cats do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
