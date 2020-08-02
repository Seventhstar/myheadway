class AddActualToNotice < ActiveRecord::Migration[5.1]
  def change
    add_column :notices, :actual, :boolean
  end
end
