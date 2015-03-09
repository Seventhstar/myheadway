class CreateTargetGroups < ActiveRecord::Migration
  def change
    create_table :target_groups do |t|
      t.integer :target_id
      t.integer :tgroup_id

      t.timestamps null: false
    end
  end
end
