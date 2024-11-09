class DropRelationshipsTable < ActiveRecord::Migration[7.2]
  def up
    drop_table :relationships
  end

  def down
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.index :followed_id, name: "index_relationships_on_followed_id"
      t.index [ :follower_id, :followed_id ], name: "index_relationships_on_follower_id_and_followed_id", unique: true
      t.index :follower_id, name: "index_relationships_on_follower_id"
    end
  end
end
