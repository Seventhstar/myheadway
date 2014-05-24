class AddBooksToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :book_id, :integer
  end
end
