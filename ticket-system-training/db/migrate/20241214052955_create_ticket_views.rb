class CreateTicketViews < ActiveRecord::Migration[7.2]
  def change
    create_table :ticket_views do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
