class CreateStatementstags < ActiveRecord::Migration
  def change
    create_table :statementstags do |t|
      t.integer :statement_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
