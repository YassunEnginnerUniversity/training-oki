class CreateTickets < ActiveRecord::Migration[7.2]
  def change
    create_table :tickets do |t|
      t.datetime :used_time
      t.datetime :transfer_time
      t.references :ticket_type, null: false, foreign_key: true
      t.references :entrance, null: false, foreign_key: true
      t.references :ticket_view, null: false, foreign_key: true

      t.timestamps
    end
  end
end
