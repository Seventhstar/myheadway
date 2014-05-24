class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.string :name
      t.integer :parent_id
      t.integer :user_id
      t.integer :group_id

      t.timestamps
    end
  end
end
