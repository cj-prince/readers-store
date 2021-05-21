class AddApprovedToBorrow < ActiveRecord::Migration[6.1]
  def change
    add_column :borrows, :status, :string, default: 'pending'
  end
end
