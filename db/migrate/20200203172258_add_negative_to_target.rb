class AddNegativeToTarget < ActiveRecord::Migration[5.1]
  def change
    add_column :targets, :negative, :boolean
  end
end
