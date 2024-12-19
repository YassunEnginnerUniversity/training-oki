class CreatePlayGuides < ActiveRecord::Migration[7.2]
  def change
    create_table :play_guides do |t|
      t.string :name

      t.timestamps
    end
  end
end
