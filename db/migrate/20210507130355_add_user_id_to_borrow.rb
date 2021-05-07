class AddUserIdToBorrow < ActiveRecord::Migration[6.1]
  def change
    add_column :borrows, :user_id, :integer
  end
end
