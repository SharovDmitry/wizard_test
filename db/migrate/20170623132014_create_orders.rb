class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :city
      t.string :date
      t.string :hotel
      t.integer :user_id

      t.timestamps
    end

    add_index :orders, :user_id
  end
end