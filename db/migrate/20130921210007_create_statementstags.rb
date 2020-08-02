class CreateStatementstags < ActiveRecord::Migration[5.1]
  def change
    create_table :statementstags do |t|
      t.integer :statement_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
