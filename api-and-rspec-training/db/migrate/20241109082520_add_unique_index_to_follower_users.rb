class AddUniqueIndexToFollowerUsers < ActiveRecord::Migration[7.2]
  def change
    add_index :follow_users, [:follower_id, :followed_id], unique: true, name: 'index_follow_users_on_follower_id_and_followed_id'
  end
end
