class AddActualToAttention < ActiveRecord::Migration
  def change
    add_column :attentions, :actual, :boolean
    add_column :attentions, :author_id, :integer
  end
end
