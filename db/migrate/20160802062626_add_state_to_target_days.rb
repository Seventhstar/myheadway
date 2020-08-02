class AddStateToTargetDays < ActiveRecord::Migration[5.1]
  def change
    add_column :target_days, :state, :integer
    add_column :target_days, :value, :integer
  end
end
