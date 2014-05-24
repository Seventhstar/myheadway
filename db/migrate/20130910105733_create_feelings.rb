class CreateFeelings < ActiveRecord::Migration
  def change
    create_table :feelings do |t|
      t.text :content
      t.date :day

      t.timestamps
    end
  end
end
