class CreateHotels < ActiveRecord::Migration[5.0]
  def change
    create_table :hotels do |t|
      t.string :name
      t.integer :city_id
    end

    add_index :hotels, :city_id
  end
end