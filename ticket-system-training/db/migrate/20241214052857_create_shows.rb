class CreateShows < ActiveRecord::Migration[7.2]
  def change
    create_table :shows do |t|
      t.string :name
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.text :details
      t.references :organizer, null: false, foreign_key: true
      t.references :play_guide, null: false, foreign_key: true

      t.timestamps
    end
  end
end
