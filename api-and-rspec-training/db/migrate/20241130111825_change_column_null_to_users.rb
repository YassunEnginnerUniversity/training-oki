class ChangeColumnNullToUsers < ActiveRecord::Migration[7.2]
  def up
    User.where(profile: nil).update_all(profile: "")
    change_column_null :users, :profile, false
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "このマイグレーションは元に戻せません"
  end
end
