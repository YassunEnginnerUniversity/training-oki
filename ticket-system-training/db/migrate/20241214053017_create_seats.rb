class CreateSeats < ActiveRecord::Migration[7.2]
  def change
    create_table :seats do |t|
      t.string :seat_area
      t.integer :seat_number
      t.references :ticket, null: false, foreign_key: true

      t.timestamps
    end
  end
end
