class AddDefaultFixedToTasks < ActiveRecord::Migration[6.0]
  def up
    change_column :tasks, :fixed, :boolean, default: false
  end
end
