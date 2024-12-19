class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :name
      t.text :details
      t.date :date
      t.string :venue
      t.time :open_time
      t.time :start_time
      t.time :end_time
      t.text :notes
      t.references :show, null: false, foreign_key: true

      t.timestamps
    end
  end
end
