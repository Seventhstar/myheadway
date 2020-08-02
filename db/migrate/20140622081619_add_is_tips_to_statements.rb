class AddIsTipsToStatements < ActiveRecord::Migration[5.1]
  def change
    add_column :statements, :isTip, :boolean
  end
end
