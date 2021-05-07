class CreateBorrows < ActiveRecord::Migration[6.1]
  def change
    create_table :borrows do |t|
      t.date :start_date
      t.date :end_date
      t.text :comment

      t.timestamps
    end
  end
end
