class AddNamesToTargets < ActiveRecord::Migration[5.1]
  def change
    add_column :targets, :sets_name_id, :integer
    add_column :targets, :count_name_id, :integer
  end
end
