class CreateBenefits < ActiveRecord::Migration[7.2]
  def change
    create_table :benefits do |t|
      t.string :name
      t.text :details
      t.datetime :used_time
      t.references :ticket, null: false, foreign_key: true

      t.timestamps
    end
  end
end
