class AddImgNumToTaskCat < ActiveRecord::Migration[6.0]
  def change
    add_column :task_cats, :img_num, :integer
  end
end
