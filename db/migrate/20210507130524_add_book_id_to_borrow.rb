class AddBookIdToBorrow < ActiveRecord::Migration[6.1]
  def change
    add_column :borrows, :book_id, :integer
  end
end
