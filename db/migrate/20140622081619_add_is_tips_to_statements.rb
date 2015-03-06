class AddIsTipsToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :isTip, :boolean
  end
end
