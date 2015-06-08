class ChangeStartDateDenials < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :denials do |t|
        dir.up   { t.change :start_date, :date }
#        dir.down { t.change :start_date, :datetime }
      end
    end
  end
end
