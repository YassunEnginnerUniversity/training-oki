class AddConstraintsToUsersUsername < ActiveRecord::Migration[7.2]
  def change
    change_column_null :users, :username, false
    add_index :users, :username, unique: true
  end
end
