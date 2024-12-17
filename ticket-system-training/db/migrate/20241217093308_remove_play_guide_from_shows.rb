class RemovePlayGuideFromShows < ActiveRecord::Migration[7.2]
  def change
    remove_reference :shows, :play_guide, foreign_key: true
  end
end
