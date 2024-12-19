class AddPlayGuideToTickets < ActiveRecord::Migration[7.2]
  def change
    add_reference :tickets, :play_guide, foreign_key: true
  end
end
