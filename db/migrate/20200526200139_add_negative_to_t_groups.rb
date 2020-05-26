class AddNegativeToTGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :tgroups, :negative, :boolean
  end
end
