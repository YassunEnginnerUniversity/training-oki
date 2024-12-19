class CreateTransfers < ActiveRecord::Migration[7.2]
  def change
    create_table :transfers do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.references :ticket_view, null: false, foreign_key: true

      t.timestamps
    end
  end
end
