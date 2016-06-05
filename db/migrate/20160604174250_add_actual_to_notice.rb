class AddActualToNotice < ActiveRecord::Migration
  def change
    add_column :notices, :actual, :boolean
  end
end
