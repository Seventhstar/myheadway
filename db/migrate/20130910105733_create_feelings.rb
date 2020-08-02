class CreateFeelings < ActiveRecord::Migration[5.1]
  def change
    create_table :feelings do |t|
      t.text :content
      t.date :day

      t.timestamps
    end
  end
end
