class CreateTicketTypes < ActiveRecord::Migration[7.2]
  def change
    create_table :ticket_types do |t|
      t.string :name
      t.float :price
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
