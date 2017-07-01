class CreateCheckInDates < ActiveRecord::Migration[5.0]
  def change
    create_table :check_in_dates do |t|
      t.string :date
      t.integer :hotel_id
    end

    add_index :check_in_dates, :hotel_id
  end
end